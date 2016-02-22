<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" description="The DOM element id of the &lt;a&gt; link that opens the popover." %>
<%@ attribute name="title" required="true" description="The string or message code for the resource bundle message that will be the header text above the opened popover content." %>
<%@ attribute name="triggerClass" required="false" description="The CSS classes to apply to the &lt;a&gt; that opens the popover." %>
<%@ attribute name="message" required="true" description="The string message code for the resource bundle message that will be the help text." %>
<%@ attribute name="trigger" required="false" description="How popover is triggered - click | hover | focus | manual. You may pass multiple triggers; separate them with a space." %>
<%@ attribute name="triggerTitle" required="false" description="The string or message code for the resource bundle message for text to display next to icon." %>

<spring:message var="message" code="${message}" text="${message}" />
<spring:message var="title" code="${title}" text="${title}" />
<spring:message var="triggerTitle" code="${triggerTitle}" text="${triggerTitle}"/>

<c:if test="${empty trigger}">
    <c:set var="trigger" value="click" />
</c:if>

<button type="button" class="popoverHelp btn-link" aria-hidden="true" title="${title}" id="${id}">
    <span class="${triggerClass}"></span> <span class="trigger-title">${triggerTitle}</span>
</button>

<span class="sr-only"><strong>${title}</strong><br />${message}</span>

<script>
    $(function(){
        $("#${id}").popover({
            html: true,
            trigger: "${trigger}",
            container: "body",
            placement: "top",
            delay: { "show": 300, "hide": 100 },
            content: "<spring:escapeBody javaScriptEscape="true" htmlEscape="false">${message}</spring:escapeBody>"
        });
    });
</script>
