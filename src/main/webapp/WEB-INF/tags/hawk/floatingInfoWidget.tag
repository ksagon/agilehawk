<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="title" required="true" description="The string or message code to be displayed as the title of the widget" %>
<%@ attribute name="content" required="true" %>
<%@ attribute name="active" required="false" %>
<%@ attribute name="posTop" required="false" %>
<%@ attribute name="posBottom" required="false" %>
<%@ attribute name="posRight" required="false" %>
<%@ attribute name="posLeft" required="false" %>

<spring:message var="title" code="${title}" text="${title}" />

<script>
var width;
$(document).ready(function(){
	var shortWidth = "225px";
	$('.floating-div').width('20%');

	width = getWidthPercentage($('.floating-div'));

	$('.floating-div').find('.btn-show-hide').click(function(){
		var elem = $(this).parent();
		if (elem.find('.floating-content').is(":visible"))
		{
			width = getWidthPercentage($('.floating-div'));
			elem.animate({"width":shortWidth},500);
		}
		else
		{
			elem.animate({"width": width},500);
		}
	});

	$('.floating-div').find('.btn-show-hide').click(function(){
		$('.floating-content').slideToggle();
	});
	if($('#floatingDivActive').val() == "false")
	{
		$('#floatingDivActive').parent().find($('.floating-content')).hide();
		$('#floatingDivActive').parent().width(shortWidth);
	}
});

function getWidthPercentage(element)
{
	var width = element.width();
	var parentWidth = $(window).offsetParent().width();
	return Math.round(100*width/parentWidth) + "%";
}
</script>
<div id="${id}" class="widget-box span8 floating-div" id="${id}" style="position:fixed; right:${posRight}; top:${posTop}; background:rgb(255, 255, 255); padding:7px; -moz-box-shadow: 4px 4px 25px 3px #999; -webkit-box-shadow: 4px 4px 25px 3px #999;">
	<input type="hidden" id="floatingDivActive" value="${active}">
	<div class="btn-show-hide" style="cursor:pointer; position:absolute; top: 7px; right: 10px; font-size:small"><strong>show/hide</strong></div>
    <div class="widget-title">
        ${title}
    </div>
    <div class="widget-content floating-content">
        ${content}
    </div>
</div>


