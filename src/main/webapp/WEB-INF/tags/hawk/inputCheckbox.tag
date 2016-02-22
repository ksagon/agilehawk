<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="path" required="true" %>

<%@ attribute name="label" required="false" description="Applies a label to the checkbox. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="id" required="false" description="If empty, the checkbox's path attribute will be used for its id attribute" %>

<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>

<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<c:choose>
    <c:when test="${not empty labelCode}">
        <spring:message var="label" code="${labelCode}" text="${label}" />
    </c:when>
    <c:otherwise>
        <spring:message var="label" code="${label}" text="${label}" />
    </c:otherwise>
</c:choose>
<c:set var="id" value="${empty pageScope.id ? pageScope.path : pageScope.id}" />
<c:set var="id" value="${fn:replace(id, '[', '')}" />
<c:set var="id" value="${fn:replace(id, ']', '')}" />

<edo:inputBase path="${path}" controlGroupClass="${controlGroupClass}" controlsClass="checkbox-controls"
               readonly="${readonly}" readonlyMessageHtmlEscape="false" inputOnly="${inputOnly}" colspan="${colspan}">
    <jsp:attribute name="inputField">
        <div class="checkbox">
            <form:checkbox id="${id}" path="${path}" cssClass="${inputClass}" /> <label for="${id}" class="${labelClass} ${required ? 'required-label' : ''}">${label}</label>
        </div>
    </jsp:attribute>
    <jsp:attribute name="readonlyMessage">
        <spring:bind path="${path}">
            <c:choose>
                <c:when test="${status.actualValue eq true}">
                    <i class="fa fa-fw fa-check-square-o"></i>
                </c:when>
                <c:otherwise>
                    <i class="fa fa-fw fa-square-o"></i>
                </c:otherwise>
            </c:choose>
            ${label}
        </spring:bind>
    </jsp:attribute>
</edo:inputBase>
