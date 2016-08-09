<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="path" required="true" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use labelClass='sr-only' to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>
<%@ attribute name="multiple" required="false" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<%@ attribute name="popoverHelpTitle" required="false" description="title for popup help modal" %>
<%@ attribute name="popoverHelpMessage" required="false" description="text for popup help" %>
<%@ attribute name="inlineHelpMessage" required="false" description="text to appear by field" %>

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>

<c:if test="${readonly}">
    <c:set var="readonlyMessage"><spring:bind path="${path}">${status.actualValue}</spring:bind></c:set>
</c:if>

<spring:eval var="icons" expression="T(com.edo.marketing.ui.model.Icon).getSortedSet()" />
<hawk:inputBase path="${path}" label="${label}" labelCode="${labelCode}" required="${required}" controlGroupClass="${controlGroupClass}"
               labelClass="${labelClass}" readonly="${readonly}" readonlyMessage="${readonlyMessage}" inputOnly="${inputOnly}"
               colspan="${colspan}" popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}">
    <jsp:attribute name="inputField">
        <form:select class="select2-ignore" path="${path}" multiple="${multiple}" data-placeholder="${placeholder}" >
            <c:if test="${not empty placeholder}"><option></option></c:if>
            <c:forEach var="icon" items="${icons}">
                <form:option value="${icon}" data-iconclass="${icon.cssClass}">${icon.name}</form:option>
            </c:forEach>
        </form:select>
    </jsp:attribute>
</hawk:inputBase>

<script type="text/javascript">
    $(function() {
        function format(icon) {
            var originalOption = icon.element;
            return '<i class="fa ' + $(originalOption).data('iconclass') + ' icon-align-right"></i>  ' + icon.text;
        }
        $("#${path}").select2({
            formatResult: format,
            formatSelection: format,
            escapeMarkup: function(m) { return m; }
        });
    });
</script>