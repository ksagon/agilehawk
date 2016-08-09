<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="rows" required="true" %>
<%@ attribute name="length" required="false" %>
<%@ attribute name="label" required="false" description="Applies a label to the textarea. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use labelClass='sr-only' to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="id" required="false" description="If empty, the element's path attribute will be used for its id attribute" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>
<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:set var="id" value="${empty pageScope.id ? path : pageScope.id}" />


<hawk:inputBase path="${path}" label="${label}" id="${id}" labelCode="${labelCode}" required="${required}" controlGroupClass="input-textarea ${controlGroupClass}"
               labelClass="${labelClass}" readonly="${readonly}" inputOnly="${inputOnly}" colspan="${colspan}"
               popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}">
    <jsp:attribute name="inputField">
        <form:textarea path="${path}" id="${id}" cssClass="${inputClass} form-control" rows="${rows}" placeholder="${placeholder}"/>
        <span id="${id}_message_warning" class="hidden"></span>
    </jsp:attribute>
</hawk:inputBase>

<script>
    <c:if test="${not empty length}">
        $("#${id}").keyup(function() {
            var i = ${length} - $(this).val().length;
            var warningSpan = $("#${id}_message_warning");
            var warningText = "<spring:message code="ux.copy.inputTextArea.characterLimitWarning" arguments="%d" text="%d characters remaining" />";
            warningSpan.removeClass("hidden");
            warningSpan.text(sprintf(warningText, i));
            if (i < 0) {
                warningSpan.addClass("warning");
            } else {
                warningSpan.removeClass("warning");
            }
        });
    </c:if>
</script>
