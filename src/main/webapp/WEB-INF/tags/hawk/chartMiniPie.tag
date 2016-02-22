<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="id" required="true" description="The unique DOM ID of the span that the chart will be made from." %>

<%@ attribute name="values" type="java.util.List" required="false" description="A Java List containing each number value that will map to each wedge in the pie chart. Either this attribute or both 'value' and 'total' attributes are required." %>

<%@ attribute name="value" type="java.lang.Number" required="false" description="A single pie wedge value, only to be used in combination with the 'total' attribute. Is required if 'values' attribute is not set." %>
<%@ attribute name="total" type="java.lang.Number" required="false" description="The total value of the pie, only to be used in combination with the 'value' attribute. Is required if 'values' attribute is not set." %>

<%@ attribute name="diameter" required="false" description="The diameter of the pie chart, in pixels." %>
<%@ attribute name="colors" required="false" description="A comma-separated list of colors for each pie wedge, e.g.: #5c8727,#bbbbbb,#123456" %>

<c:if test="${not empty colors}">
    <c:set var="dataFill">data-fill="<c:out value="[\"${fn:replace(colors, ',', '\",\"')}\"]"/>"</c:set>
</c:if>
<c:if test="${not empty diameter}">
    <c:set var="dataDiameter">data-diameter="${diameter}"</c:set>
</c:if>

<c:choose>
    <c:when test="${not empty value and not empty total}">
        <c:set var="data" value="${value}/${total}" />
    </c:when>
    <c:when test="${not empty values}">
        <c:forEach var="val" items="${values}" varStatus="loop">
            <c:set var="data" value="${data}${not empty data ? ',' : ''}${val}" />
        </c:forEach>
    </c:when>
</c:choose>

<c:if test="${not empty data}">
    <span id="${id}" ${dataFill} ${dataDiameter}>${data}</span>
    
    <script type="text/javascript">
        $(document).ready(function() {
            $("#${id}").peity("pie");
        });
    </script>
</c:if>
