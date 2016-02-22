<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="currencyCode" required="true" description="The currency code that shows up on the left addon of the input"%>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="id" required="false" description="If empty, the element's path attribute will be used for its id attribute" %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Uses the provided placeholder as a message code for the i18n message bundle." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder and provide a message code" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="maxFractionDigits" description="Maximum number of fractional digits to print" required="false" %>
<%@ attribute name="minFractionDigits" description="Minimum number of fractional digits to print" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<c:set var="id" value="${empty pageScope.id ? pageScope.path : pageScope.id}" />
<c:set var="maxFractionDigits" value="${empty maxFractionDigits ? 0 : maxFractionDigits}" />
<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>

<edo:inputBase path="${path}" label="${label}" labelCode="${labelCode}" required="${required}" controlGroupClass="input-currency ${controlGroupClass}" labelClass="${labelClass}"
               readonly="${readonly}" id="${id}" inputOnly="${inputOnly}" colspan="${colspan}"
               popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}">
    <jsp:attribute name="inputField">
        <div class="input-group">
            <span class="input-group-addon currency-descriptor">${currencyCode}</span>
            <edo:inputNumber path="${path}" id="${id}" maxFractionDigits="${maxFractionDigits}" minFractionDigits="${minFractionDigits}" placeholder="${placeholder}" inputOnly="true" />
        </div>
    </jsp:attribute>
</edo:inputBase>
