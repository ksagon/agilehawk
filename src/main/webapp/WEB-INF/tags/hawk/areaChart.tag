<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="url" required="true" %>
<%@ attribute name="title" required="true" description="message code or string to be used as title for chart" %>
<%@ attribute name="postData" required="true" %>

<%@ attribute name="width" required="false" %>
<%@ attribute name="height" required="false" %>
<%@ attribute name="yunitLeft" required="false" %>
<%@ attribute name="yunitRight" required="false" %>

<spring:message var="title" code="${title}" text="${title}" />
<c:url var="url" value="${url}"/>
<c:if test="${empty width}">
    <c:set var="width" value="document.getElementById('${id}').offsetWidth"/>
</c:if>
<c:if test="${empty height}">
    <c:set var="height" value="260"/>
</c:if>

<div id="${id}" class="area-chart hidden-xs"></div>

<script>
    $(document).ready(function() {
        var ${id} = new AreaChart("#${id}", "${url}", "${title}", ${width}, ${height});
        ${id}.yUnitLeft = "${yunitLeft}";
        ${id}.yUnitRight = "${yunitRight}";
        ${id}.draw(JSON.stringify(${postData}));

        function resizeChart() {
            ${id}.setWidth(document.getElementById("${id}").offsetWidth);
            ${id}.redraw();
        }

        var timeoutAction;
        $(window).resize(function() {
            clearTimeout(timeoutAction);
            timeoutAction = setTimeout(function() {
                resizeChart();
            }, 500);
        });
    });
</script>
