<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="id" required="true" description="The unique DOM ID of the span that the chart will be made from." %>

<%@ attribute name="values" type="java.util.List" required="true" description="A Java List containing each number value that will map to each data point in the line chart." %>

<%@ attribute name="lineWidth" required="false" description="The width in pixels of the line." %>

<%@ attribute name="height" required="false" description="The height of the line chart, in pixels." %>
<%@ attribute name="width" required="false" description="The width of the line chart, in pixels." %>

<%@ attribute name="lineColor" required="false" description="The color of the line, e.g.: #5c8727." %>
<%@ attribute name="fillColor" required="false" description="The color beneath the line, e.g.: #5c8727. Default color is white." %>

<c:set var="dataFill">data-fill="${empty fillColor ? '#ffffff' : fillColor}"</c:set>
<c:if test="${not empty lineColor}">
    <c:set var="dataStroke">data-stroke="${lineColor}"</c:set>
</c:if>
<c:if test="${not empty lineWidth}">
    <c:set var="dataStrokeWidth">data-strokeWidth="${lineWidth}"</c:set>
</c:if>
<c:if test="${not empty height}">
    <c:set var="dataHeight">data-height="${height}"</c:set>
</c:if>
<c:if test="${not empty width}">
    <c:set var="dataWidth">data-width="${width}"</c:set>
</c:if>

<c:set var="data" />
<c:forEach var="value" items="${values}" varStatus="loop">
    <c:set var="data" value="${data}${not empty data ? ',' : ''}${value}" />
</c:forEach>

<span id="${id}" ${dataFill} ${dataStroke} ${dataStrokeWidth} ${dataHeight} ${dataWidth}>${data}</span>

<script type="text/javascript">
    $(document).ready(function() {
        $("#${id}").peity("line");
    });
</script>
