<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="multiple" required="false" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>

<c:set var="currentValueJSON">
    <spring:bind path="${path}">${edofn:toJSON(status.actualValue)}</spring:bind>
</c:set>

<c:url var="domainControllerURL" value="/m/institution/list" />

<edo:inputBase path="${path}" required="${required}" colspan="${colspan}" label="${label}" readonly="${readonly}">
    <jsp:attribute name="inputField">
        <form:select path="${path}" multiple="${multiple}" data-placeholder="${placeholder}" />
    </jsp:attribute>

    <jsp:attribute name="readonlyMessage">
        <spring:bind path="${path}">
            ${status.actualValue.name}
        </spring:bind>
    </jsp:attribute>
</edo:inputBase>

<script type="text/javascript">
    $(function() {
        loadOptions("${domainControllerURL}", "${path}", ${currentValueJSON} , "institutionId", "name");
    });
</script>
