<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="id" required="true" description="The unique DOM ID of the span that the chart will be made from." %>

<%@ attribute name="values" type="java.util.List" required="true" description="A Java List containing each number value that will map to each bar in the bar chart." %>

<%@ attribute name="gap" required="false" description="The gap, in pixels, between each bar." %>

<%@ attribute name="height" required="false" description="The height of the bar chart, in pixels." %>
<%@ attribute name="width" required="false" description="The width of the bar chart, in pixels." %>

<%@ attribute name="colors" required="false" description="A comma-separated list of colors for each bar, e.g.: #5c8727,#bbbbbb,#123456. The colors will be repeated in order if there are more bars than colors." %>

<c:if test="${not empty colors}">
    <c:set var="dataFill">data-fill="<c:out value="[\"${fn:replace(colors, ',', '\",\"')}\"]"/>"</c:set>
</c:if>
<c:if test="${not empty gap}">
    <c:set var="dataGap">data-gap="${gap}"</c:set>
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

<span id="${id}" ${dataFill} ${dataGap} ${dataHeight} ${dataWidth}>${data}</span>

<script type="text/javascript">
    $(document).ready(function() {
        $("#${id}").peity("bar");
    });
</script>
