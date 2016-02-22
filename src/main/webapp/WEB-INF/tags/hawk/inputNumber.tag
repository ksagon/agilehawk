<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="path" required="true" %>

<%@ attribute name="multiplier" required="false" description="Multiplier for the number, e.g. to display a percent as '55' instead of '.55', you would use a multiplier of 100." %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="id" required="false" description="If empty, the element's path attribute will be used for its id attribute" %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>
<%-- formatting attributes --%>
<%@ attribute name="type" description="NUMBER, CURRENCY, or PERCENT" required="false" %>
<%@ attribute name="pattern" description="Specify a custom formatting pattern for the output." required="false" %>
<%@ attribute name="currencyCode" description="Currency code (for type='currency')" required="false" %>
<%@ attribute name="currencySymbol" description="Currency symbol (for type='currency')" required="false" %>
<%@ attribute name="groupingUsed" description="Whether to group numbers (TRUE or FALSE)" required="false" %>
<%@ attribute name="maxIntegerDigits" description="Maximum number of integer digits to print" required="false" %>
<%@ attribute name="minIntegerDigits" description="Minimum number of integer digits to print" required="false" %>
<%@ attribute name="maxFractionDigits" description="Maximum number of fractional digits to print" required="false" %>
<%@ attribute name="minFractionDigits" description="Minimum number of fractional digits to print" required="false" %>
<%@ attribute name="addonLabel" required="false" description="Text/message code that will be displayed (if present) in the coner of the input field" %>

<c:set var="multiplier" value="${empty multiplier ? 1 : multiplier}" />
<c:set var="id" value="${empty pageScope.id ? pageScope.path : pageScope.id}" />

<c:set var="numberVal"><spring:bind path="${path}">${status.actualValue}</spring:bind></c:set>
<c:set var="numberVal" value="${empty numberVal ? '' : numberVal * multiplier}" />
<c:set var="type" value="${empty type ? 'NUMBER' : type}" />
<c:set var="groupingUsed" value="${empty groupingUsed ? 'false' : groupingUsed}" />
<c:set var="maxIntegerDigits" value="${empty maxIntegerDigits ? 99999999999 : maxIntegerDigits}" />

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>

<fmt:formatNumber var="fmtNumberVal" value="${numberVal}" type="${type}" pattern="${pattern}" currencyCode="${currencyCode}"
            currencySymbol="${currencySymbol}" groupingUsed="${groupingUsed}" maxIntegerDigits="${maxIntegerDigits}"
            maxFractionDigits="${maxFractionDigits}" minIntegerDigits="${minIntegerDigits}" minFractionDigits="${minFractionDigits}" />
<edo:inputText path="${path}" label="${label}" labelCode="${labelCode}" required="${required}" value="${fmtNumberVal}"
               placeholder="${placeholder}" popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}"
               controlGroupClass="${controlGroupClass}" inputClass="${inputClass} input-number" labelClass="${labelClass}"
               readonly="${readonly}" id="${id}" inputOnly="${inputOnly}" colspan="${colspan}" addonLabel="${addonLabel}"/>
