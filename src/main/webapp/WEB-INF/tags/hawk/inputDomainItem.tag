<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="domainType" required="true" description="The domain type to load. See DomainType enum." %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="multiple" required="false" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="inlineHelpMessage" required="false" description="provide a helpful message or message code here to be displayed inline with the input element" %>
<%@ attribute name="popoverHelpTitle" required="false" description="provide a title to the given popover help message" %>
<%@ attribute name="popoverHelpMessage" required="false" description="provide a helpful message or message code here to be displayed as a popover element with the input element" %>

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>
<c:set var="currentValueJSON">
    <spring:bind path="${path}">${edofn:toJSON(status.actualValue)}</spring:bind>
</c:set>
<spring:message var="inlineHelpMessage" code="${inlineHelpMessage}" text="${inlineHelpMessage}"/>
<c:url var="domainControllerURL" value="/m/domainItem/list?domainType=${domainType}" />

<edo:inputBase path="${path}" required="${required}" colspan="${colspan}" label="${label}" labelCode="${labelCode}" readonly="${readonly}" inlineHelpMessage="${inlineHelpMessage}" popoverHelpTitle="${popoverHelpTitle}" popoverHelpMessage="${popoverHelpMessage}">
    <jsp:attribute name="inputField">
        <form:select path="${path}" multiple="${multiple}" data-placeholder="${placeholder}" />
    </jsp:attribute>

    <jsp:attribute name="readonlyMessage">
        <spring:bind path="${path}">
            <c:choose>
                <c:when test="${status.valueType.simpleName eq 'DomainItemDTO' || status.valueType.simpleName eq 'DomainItem'}">
                    ${status.actualValue.domainValue}
                </c:when>
                <c:otherwise>
                    <%-- Catch the error when parsing foreach if supplied value is not a collection --%>
                    <c:catch>
                        <c:forEach items="${status.actualValue}" var="category" varStatus="status">
                            ${category.domainValue}<c:if test="${not status.last}">, </c:if>
                        </c:forEach>
                    </c:catch>
                </c:otherwise>
            </c:choose>
        </spring:bind>
    </jsp:attribute>
</edo:inputBase>

<script type="text/javascript">
    $(function() {
        loadOptions("${domainControllerURL}", "${path}", ${currentValueJSON}, "name", "domainValue");
    });
</script>