<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="path" required="true" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use labelClass='sr-only' to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="id" required="false" description="If empty, the element's path attribute will be used for its id attribute" %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>

<%@ attribute name="allowPaste" required="false" description="When set as 'false', will prevent users from pasting any text from the clipboard into this field. Defaults to 'true'." %>
<%@ attribute name="allowAutocomplete" required="false" description="When set as 'false', will suppress browsers' builtin autocomplete suggestions." %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>
<c:set var="id" value="${empty pageScope.id ? pageScope.path : pageScope.id}" />


<hawk:inputText path="${path}" spellcheck="false" label="${label}" labelCode="${labelCode}" required="${required}"
               placeholder="${placeholder}" popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}"
               controlGroupClass="${controlGroupClass}" inputClass="${inputClass}" labelClass="${labelClass}"
               readonly="${readonly}" inputOnly="${inputOnly}" id="${id}" colspan="${colspan}" allowAutocomplete="${allowAutocomplete}" />

<c:set var="allowPaste" value="${empty allowPaste ? 'true' : allowPaste}" />
<c:if test="${not allowPaste}">
    <script>
        hawk.util.getElement("${path}").on("paste", function(event) {
            event.preventDefault();
        });
    </script>
</c:if>
