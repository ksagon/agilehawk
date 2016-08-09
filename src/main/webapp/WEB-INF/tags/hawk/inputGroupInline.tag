<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="false" description="A DOM id for the outer DIV around the input group." %>

<%@ attribute name="label" required="false" description="Applies a label to the input group. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use labelClass='sr-only' to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>

<%@ attribute name="required" required="false" %>
<%@ attribute name="controlGroupClass" required="false" %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<c:set var="popoverHelpId" value="${fn:toLowerCase(fn:replace(label, ' ', '_'))}_help" />

<c:if test="${not empty popoverHelpTitle && not empty popoverHelpMessage}">
    <c:set var="hasPopoverHelp" value="true" />
</c:if>

<c:choose>
    <c:when test="${not empty labelCode}">
        <spring:message var="label" code="${labelCode}" text="${label}" />
    </c:when>
    <c:otherwise>
        <spring:message var="label" code="${label}" text="${label}" />
    </c:otherwise>
</c:choose>

<div id="${id}" class="form-inline-group clearfix ${controlGroupClass}">
    <span class="control-label">
        <span class="spacer invisible"></span>
        <label class="${required ? 'required-label' : ''}">${label}
        <c:if test="${hasPopoverHelp}">
            <hawk:popoverHelp id="${popoverHelpId}" title="${popoverHelpTitle}" message="${popoverHelpMessage}" />
        </c:if>
        </label>
    </span>
    <jsp:doBody />
</div>
