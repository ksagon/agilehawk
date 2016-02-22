<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="path" required="true" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="multiple" required="false" %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>

<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>
<c:url var="stateControllerURL" value="/m/state/list" />

<c:set var="currentValue">
    <spring:bind path="${path}">${edofn:toJSON(status.actualValue)}</spring:bind>
</c:set>

<edo:inputBase path="${path}" required="${required}" colspan="${colspan}" label="${label}" readonly="${readonly}">
    <jsp:attribute name="inputField">
        <form:select path="${path}" multiple="${multiple}" data-placeholder="${placeholder}" />
    </jsp:attribute>

    <jsp:attribute name="readonlyMessage">
        <spring:bind path="${path}">
            <c:choose>
                <c:when test="status.valueType.simpleName eq State">
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
        loadOptions('${stateControllerURL}', '${path}', ${currentValue}, 'abbreviation', 'name');
    });
</script>