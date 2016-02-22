<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ tag description="A marker pin to be included on a map. Intended for use within the <code>edo:map</code> <code>marker</code> attribute." %>

<%@ attribute name="id" required="false" description="Deprecated" %>
<%@ attribute name="title" required="true" description="Message code, text or HTML that shows up in marker info bubble" %>
<%@ attribute name="markerLat" required="true" description="Marker latitude" %>
<%@ attribute name="markerLong" required="true" description="Marker longitude" %>
<spring:message var="title" code="${title}" text="${title}" />

mapMarkers.push({ coordinates: { lat: ${markerLat}, lng: ${markerLong} },
                  content: "<spring:escapeBody javaScriptEscape="true" htmlEscape="false">${title}</spring:escapeBody>" });
