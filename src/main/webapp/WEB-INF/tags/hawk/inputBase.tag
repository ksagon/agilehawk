<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%@ attribute name="id" required="false" description="If empty, the element's path attribute will be used for its id attribute" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="inputField" required="true" fragment="true" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="controlsClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="readonlyMessage" required="false" %>
<%@ attribute name="readonlyMessageHtmlEscape" required="false" %>

<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<c:set var="baseId" value="${empty pageScope.id ? path : pageScope.id }" />
<c:set var="baseId" value="${fn:replace(baseId, '[', '')}" />
<c:set var="baseId" value="${fn:replace(baseId, ']', '')}" />
<c:set var="controlGroupId" value="${baseId}_control_group" />
<c:set var="inlineHelpId" value="${baseId}_help" />
<c:set var="inlineErrorId" value="${baseId}_errors" />

<c:set var="errorMsg"><spring:bind path="${path}">${status.errorMessage}</spring:bind></c:set>
<c:set var="hasError" value="${empty errorMsg ? '' : 'has-error'}" />

<c:if test="${readonly and empty readonlyMessage}">
    <c:set var="readonlyMessage"><spring:bind path="${path}">${status.value}</spring:bind></c:set>
</c:if>
<c:if test="${empty readonlyMessageHtmlEscape or readonlyMessageHtmlEscape}">
    <c:set var="readonlyMessage"><edo:out value="${readonlyMessage}" /></c:set>
</c:if>

<c:set var="inputControl">
    <c:choose>
        <c:when test="${readonly}">
            <p id="${baseId}" class="form-control-static">${readonlyMessage}</p>
        </c:when>
        <c:otherwise>
            <jsp:invoke fragment="inputField" />
            <c:if test="${not inputOnly}"><span id="${inlineErrorId}" class="help-block"><form:errors path="${path}" /></span></c:if>
        </c:otherwise>
    </c:choose>
</c:set>

<c:choose>
    <c:when test="${inputOnly}">
        ${inputControl}
    </c:when>
    <c:otherwise>
        <edo:formControlGroup id="${controlGroupId}" cssClass="${hasError} ${controlGroupClass}" colspan="${colspan}" controlsClass="${controlsClass}"
                              label="${label}" labelCode="${labelCode}" labelClass="${labelClass}" labelFor="${baseId}" required="${required}"
                              popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}">
            ${inputControl}
        </edo:formControlGroup>
    </c:otherwise>
</c:choose>
