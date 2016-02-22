<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" description="The DOM element id of the &lt;a&gt; link that opens the popover." %>
<%@ attribute name="title" required="true" description="The message code for the resource bundle message that will be the header text above the opened popover content." %>
<%@ attribute name="triggerClass" required="false" description="The CSS classes to apply to the &lt;a&gt; that opens the popover." %>
<%@ attribute name="message" required="true" description="The message inside the popover. Can be any valid HTML." %>
<%@ attribute name="placement" required="false" description="How to position the popover - top | bottom | left | right | auto." %>
<%@ attribute name="trigger" required="false" description="How popover is triggered - click | hover | focus | manual. You may pass multiple triggers; separate them with a space." %>
<%@ attribute name="triggerTitle" required="false" description="The message code for the resource bundle message for text to display next to icon." %>

<spring:message var="triggerTitle" code="${triggerTitle}" text="${triggerTitle}"/>
<spring:message var="title" code="${title}" text="${title}"/>

<c:if test="${empty triggerClass}">
    <c:set var="triggerClass" value="fa fa-picture-o popoverHelp" />
</c:if>

<c:if test="${empty placement}">
    <c:set var="placement" value="auto left" />
</c:if>

<c:if test="${empty trigger}">
    <c:set var="trigger" value="click" />
</c:if>

<button class="popoverHelp btn-link" data-toggle="popover" title="${title}"
   data-content="" data-container="body" id="${id}" data-trigger="${trigger}" data-placement="${placement}"
        data-template="<div class='popover popover-offer' role='tooltip'><div class='arrow'></div><h3 class='popover-title'></h3><div class='popover-content'></div></div>">
    <i class="${triggerClass}"></i> <span>${triggerTitle}</span></button>

<div id="${id}PopoverContent" class="hide">
    ${message}
</div>

<script>
    $(function(){
        $("#${id}").popover({
            html: true,
            content: function() {
                return $("#${id}PopoverContent").html();
            }
        });
    });
</script>