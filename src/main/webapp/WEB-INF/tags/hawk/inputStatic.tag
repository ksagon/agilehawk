<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="id" required="false" %>

<%@ attribute name="label" required="false" description="Applies a label to the (non)input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use labelClass='sr-only' to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<%@ attribute name="emptyMessage" required="false" description="text that appears instead of a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself. (this value is not shown if there is anything in the tag body)"  %>

<c:if test="${not empty id}">
    <c:set var="controlGroupId" value="${id}_control_group" />
</c:if>
<spring:message var="emptyMessage" code="${emptyMessage}" text="${emptyMessage}" />

<c:set var="tagBody"><jsp:doBody /></c:set>
<c:set var="tagBody" value="${fn:trim(tagBody)}" />

<hawk:formControlGroup id="${controlGroupId}" label="${label}" labelCode="${labelCode}" labelClass="${labelClass}" required="${required}" colspan="${colspan}"
                      cssClass="${controlGroupClass}" popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}">
    <p id="${id}" class="form-control-static">
        <c:choose>
            <c:when test="${not empty emptyMessage && tagBody == ''}">
                <span class="text-muted">${emptyMessage}</span>
            </c:when>
            <c:otherwise>
                ${tagBody}
            </c:otherwise>
        </c:choose>
    </p>
</hawk:formControlGroup>
