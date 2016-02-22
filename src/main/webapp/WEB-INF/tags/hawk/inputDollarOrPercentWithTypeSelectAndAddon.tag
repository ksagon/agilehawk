<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="amountPath" required="true" %>
<%@ attribute name="typePath" required="true" %>
<%@ attribute name="typeItems" required="true" type="java.util.Map" %>
<%@ attribute name="currencyCode" required="true" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="contingentKey" required="false" %>
<%@ attribute name="contingentFieldPath" required="false" %>

<c:set var="amountType"><spring:bind path="${typePath}">${status.value}</spring:bind></c:set>
<c:set var="multiplier" value="${fn:contains(amountType, 'PERCENT') ? 100 : 1}" />
<c:set var="maxFractionDigits" value="${fn:contains(amountType, 'PERCENT') ? 2 : 2}" />
<c:set var="minFractionDigits" value="${fn:contains(amountType, 'PERCENT') ? 0 : 2}" />

<spring:message var="explanationLabel" code="ux.label.inputDollarOrPercentWithTypeSelectAndAddon.explanation" />

<edo:inputWithSelectAddon path="${amountPath}" selectPath="${typePath}" selectPlacement="prepend" selectItems="${typeItems}"
                          required="${required}" readonly="${readonly}" controlGroupClass="input-dollar-percent-select ${controlGroupClass}"
                          label="${label}" labelCode="${labelCode}" labelClass="${labelClass}" colspan="${colspan}">
    <jsp:attribute name="inputField">
        <span id="${typePath}_addon" class="input-group-addon"><c:out value="${currencyCode}"/></span>
        <edo:inputNumber path="${amountPath}" inputOnly="true" multiplier="${multiplier}" inputClass="${inputClass}"
                         minFractionDigits="${minFractionDigits}" readonly="${readonly}" maxFractionDigits="${maxFractionDigits}" />
    </jsp:attribute>
</edo:inputWithSelectAddon>

<script type="text/javascript">
    $(document).ready(function() {
        var typeAddon = $("#${typePath}_addon");
        var contingentField = $("#${contingentFieldPath}_control_group");
        var numberInput = $("#${amountPath}");
        contingentField.hide();
        var typeSelect = edo.tag.cache.inputSelectButton.get("${typePath}");
        var typeSelectChangeFunction = function(key, value) {
            if(key === "${contingentKey}" && contingentField) {
                contingentField.show();
            } else {
                contingentField.hide();
            }

            if(~key.indexOf('PERCENT')) {
                typeAddon.text("%");
                numberInput.show();
            }
            else if(~key.indexOf('DOLLAR')) {
                typeAddon.text("${currencyCode}");
                numberInput.show();
            }
        };
        typeSelect.on("change", typeSelectChangeFunction);
        typeSelectChangeFunction(typeSelect.selectedKey);
    });
</script>
