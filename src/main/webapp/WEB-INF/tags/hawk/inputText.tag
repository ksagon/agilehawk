<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="id" required="false" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="value" required="false" %>
<%@ attribute name="spellcheck" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="maxLength" required="false" description="Sets the maximum length of the input value" %>
<%@ attribute name="minLength" required="false" description="Sets the minmum length of the input value" %>

<%@ attribute name="allowAutocomplete" required="false" description="When set as 'false', will suppress browsers' builtin autocomplete suggestions." %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>
<%@ attribute name="addonLabel" required="false" description="Text/message code that will be displayed (if present) in the coner of the input field" %>

<c:if test="${empty value}">
    <c:set var="value"><spring:bind path="${path}">${status.value}</spring:bind></c:set>
</c:if>
<c:set var="autocomplete" value="${allowAutocomplete or empty allowAutocomplete ? 'on' : 'off'}" />

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>

<c:set var="id" value="${empty pageScope.id ? pageScope.path : pageScope.id}" />
<edo:inputBase path="${path}" label="${label}" labelCode="${labelCode}" required="${required}" controlGroupClass="${controlGroupClass}"
               labelClass="${labelClass}" readonly="${readonly}" inputOnly="${inputOnly}" colspan="${colspan}"
               popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}">
    <jsp:attribute name="inputField">
         <c:choose >
             <c:when test="${not empty addonLabel}">
                 <div class="input-group">
                     <form:input id="${id}" path="${path}" value="${value}" cssClass="${inputClass} form-control"
                                 spellcheck="${spellcheck}" placeholder="${placeholder}" autocomplete="${autocomplete}" />
                     <span id="add_on_${id}" class="input-group-addon"><spring:message code="${addonLabel}" text="${addonLabel}" /></span>
                 </div>
             </c:when>
             <c:otherwise>
                 <form:input id="${id}" minLength="${minLength}" maxLength="${maxLength}" path="${path}" value="${value}" cssClass="${inputClass} form-control"
                             spellcheck="${spellcheck}" placeholder="${placeholder}" autocomplete="${autocomplete}" />
             </c:otherwise>
         </c:choose>
    </jsp:attribute>
</edo:inputBase>
