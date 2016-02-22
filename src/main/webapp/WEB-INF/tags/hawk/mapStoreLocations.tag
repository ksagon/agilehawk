<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="advertiserName" required="true" %>
<%@ attribute name="storeLocations" required="true" type="java.util.List"  %>

<c:set var="hasLatLongs" value="false" />
<c:forEach items="${storeLocations}" var="store">
    <c:if test="${store.latitude != null && store.longitude != null}">
        <c:set var="hasLatLongs" value="true" />
    </c:if>
</c:forEach>
<c:if test="${hasLatLongs}">
    <edo:map id="${id}" canvasWidth="100%">
        <jsp:attribute name="markers">
            <c:forEach items="${storeLocations}" var="store" varStatus="status">
                <c:if test="${store.latitude != null && store.longitude != null}">
                    <edo:mapMarker markerLat="${store.latitude}" markerLong="${store.longitude}">
                        <jsp:attribute name="title">
                            <c:out value="${advertiserName}" /><br /> <c:out value="${store.storeName}" /> #<c:out value="${store.storeNumber}" />
                        </jsp:attribute>
                    </edo:mapMarker>
                </c:if>
            </c:forEach>
        </jsp:attribute>
        <jsp:attribute name="disclaimer"><spring:message code="copy.storeLocation.mapDisclaimer" /></jsp:attribute>
    </edo:map>
</c:if>
