<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" description="The DOM id for the submit button." %>

<%@ attribute name="name" required="false" description="The name to be applied to submit button. Typically used to allow differentiation between different submit actions by a Spring Controller." %>

<%@ attribute name="icon" required="false" description="The icon name of any icon to be displayed next to the button text, e.g. 'rocket' or 'bar-chart'" %>
<%@ attribute name="iconPosition" required="false" description="Whether the icon specified should be shown to the left or right of the button text. Valid values are 'left' and 'right'. Defaults to left." %>
<%@ attribute name="label" required="false" description="Text for the button. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use labelClass='sr-only' to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="cssClass" required="false" description="Any CSS classes to be applied to the button" %>

<c:set var="iconPosition" value="${empty iconPosition ? 'left' : iconPosition}" />

<c:choose>
    <c:when test="${not empty labelCode}">
        <spring:message var="label" code="${labelCode}" text="${label}" />
    </c:when>
    <c:otherwise>
        <spring:message var="label" code="${label}" text="${label}" />
    </c:otherwise>
</c:choose>
<c:set var="iconLeft">
    <c:if test="${not empty icon and iconPosition eq 'left'}"><i class="fa fa-${icon}"></i></c:if>
</c:set>
<c:set var="iconRight">
    <c:if test="${not empty icon and iconPosition eq 'right'}"><i class="fa fa-${icon}"></i></c:if>
</c:set>

<form:button type="submit" id="${id}" name="${name}" class="btn ${cssClass}">
    ${iconLeft} ${label} ${iconRight}
</form:button>

<script>
    $(document).ready(function() {
        var button = edo.util.getElement("${id}");
        var form = (hawk.tag.cache.form && hawk.tag.cache.form.get("${requestScope._formId}"))
                || (hawk.tag.cache.formAjax && hawk.tag.cache.formAjax.get("${requestScope._formId}"));

        form.on("submit", disableButton);
        form.on("submitCanceled", enableButton);
        form.on("submitComplete", enableButton);

        function disableButton() {
            var buttonWidth = button.width();
            button.addClass("disabled");
            button.width(buttonWidth);
            button.html("<i class='fa fa-spinner fa-spin'></i>");
        }

        function enableButton() {
            button.html("${iconLeft} ${label} ${iconRight}");
            button.removeClass("disabled");
        }
    });
</script>
