<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ tag description="Displays an interactive map with optional marker pins and disclaimer text." %>

<%@ attribute name="id" required="true" description="Required to guarantee each map implementation is unique in the dom" %>

<%@ attribute name="canvasWidth" required="false" description="Map width. Include unit of measurement in value, e.g., 90% or 500px. Default: 500px" %>
<%@ attribute name="canvasHeight" required="false" description="Map height. Default: 300px" %>
<%@ attribute name="centerLat" required="false" description="Initial Map center latitude. Only used when no markers are present. Default: based on locale country, or 41.895357 if locale country not specified" %>
<%@ attribute name="centerLong" required="false" description="Initial Map center longitude. Only used when no markers are present. Default: based on locale country, or -87.6348869 if locale country not specified" %>
<%@ attribute name="zoom" required="false" description="Initial map zoom level. Default: based on locale country, or 8 if locale country not specified" %>
<%@ attribute name="maxZoom" required="false" description="Closest allowed zoom level." %>
<%@ attribute name="disclaimer" required="false" description="Fine print to display below map.  Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<%@ attribute name="markers" required="false" fragment="true" description="<code>&lt;edo:mapMarker&gt;</code> tags for each marker to appear on map." %>

<spring:message var="disclaimer" code="${disclaimer}" text="${disclaimer}" />
<c:set var="canvasWidth" value="${empty canvasWidth ? '500px' : canvasWidth}" />
<c:set var="canvasHeight" value="${empty canvasHeight ? '300px' : canvasHeight}" />

<c:set var="localeCountry" value="${pageContext.response.locale.country}" />
<c:set var="localeCountry" value="${empty localeCountry ? pageContext.request.locale.country : localeCountry}" />
<c:set var="countrySearch" value="${localeCountry}" />

<c:set var="zoom" value="${empty zoom ? '8' : zoom}" />

<c:choose>
    <c:when test="${not empty centerLat and not empty centerLong}">
        <c:set var="viewport" value="{ lat: ${centerLat}, lng: ${centerLong}, zoom: ${zoom} }" />
    </c:when>
    <c:when test="${not empty countrySearch}">
        <c:set var="viewport" value="{ search: \"${countrySearch}\", filter: { country: \"${localeCountry}\" } }" />
    </c:when>
    <c:otherwise>
        <c:set var="viewport" value="{ lat: 41.895357, lng: -87.6348869, zoom: ${zoom} }" />
    </c:otherwise>
</c:choose>

<div id="${id}" style="width:${canvasWidth}; height:${canvasHeight};" class="map" aria-hidden="true"></div>
<c:if test="${not empty disclaimer}">
    <h6 class="map-disclaimer">${disclaimer}</h6>
</c:if>

<script type="text/javascript">
    $(document).ready(function() {
        var mapMarkers = [];
        <jsp:invoke fragment="markers" />

        new edo.geo.Map("${id}", mapMarkers, {
            <c:if test="${not empty maxZoom}">maxZoom: ${maxZoom},</c:if>
            viewport: ${viewport}
        });
    });
</script>
