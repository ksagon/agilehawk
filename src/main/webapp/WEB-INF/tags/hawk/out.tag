<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ attribute name="value" required="true" description="Variable to print out. Expression language or string." %>
<%@ attribute name="defaultValue" required="false" description="Value to display if 'value' is empty or null." %>

<c:choose>
    <c:when test="${not empty value}">
        <c:out value="${value}" default="${defaultValue}" escapeXml="true" />
    </c:when>
    <c:otherwise>
        <c:out value="${defaultValue}" escapeXml="true" />
    </c:otherwise>
</c:choose>
