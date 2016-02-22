<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>

<%@ tag description="An input field that allows input and geocoding of location data. Can optionally display with a map." %>

<%@ attribute name="id" required="true" description="The DOM ID of the address autocomplete input." %>
<%@ attribute name="label" required="false" description="Applies a label to the address input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="labelClass" required="false" description="Any CSS classes to apply to the label." %>

<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderCode" required="false" description="deprecated, use placeholder instead" %>

<%@ attribute name="address1Path" required="false" description="The path of the 'Address 1' field in the form command object (model attribute)." %>
<%@ attribute name="address2Path" required="false" description="The path of the 'Address 2' field in the form command object (model attribute)." %>
<%@ attribute name="cityPath" required="false" description="The path of the 'City' field in the form command object (model attribute)." %>
<%@ attribute name="statePath" required="false" description="The path of the 'State' field in the form command object (model attribute). Is filled as the 2 letter state abbreviation." %>
<%@ attribute name="zipcodePath" required="false" description="The path of the 'Zip Code' field in the form command object (model attribute)." %>
<%@ attribute name="countryPath" required="false" description="The path of the 'Country' field in the form command object (model attribute)." %>
<%@ attribute name="latitudePath" required="true" description="The path of the 'Latitude' field in the form command object (model attribute)." %>
<%@ attribute name="longitudePath" required="true" description="The path of the 'Longitude' field in the form command object (model attribute)." %>

<%@ attribute name="locationTypePath" required="false" description="The path of the 'Location Type' field in the form command object (model attribute). Valid values are 'address', 'neighborhood', 'city', 'county', 'state', 'postalCode', and 'country'. This value will be used when initializing the inputAddress widget if doing a reverse geocode from lat/long, so it knows how detailed the returned address should be." %>

<%@ attribute name="allowedGeocodeLocationTypes" required="false" description="The types of locations that a Geocode lookup will allow as the returned value. Valid values are 'address', 'neighborhood', 'city', 'county', 'state', 'postalCode', and 'country'. Should be entered as comma-delimited without spaces or quotes, e.g.: city,county,state" %>

<%@ attribute name="defaultValue" required="false" description="An initial query string that should be geocoded upon initialization. Will not fire a change event. This should be used to set a default value, not as a means of repopulating existing data. That should be achieved by making sure the input fields (from the path attributes) are populated by the form's command object." %>

<%@ attribute name="required" required="false" description="Adds a visual marker that it is required to populate this input. Does NOT do any validation; is just a visual marker. Default: false" %>

<%@ attribute name="showMap" required="false" description="Shows a map of the location entered in the input field. Default: true" %>
<%@ attribute name="inputInsideMap" required="false" description="Positions the Address input field in the top left corner of the map, rather than above the map." %>
<%@ attribute name="markerInfo" required="false" description="Toggles whether the map marker will show any info (false to disable). TODO: ability to pass custom info template. Default: determined by form fields present" %>
<%@ attribute name="overwriteInputsOnInitialize" required="false" description="Determines whether the input fields should be overwritten on initialize."%>

<%@ attribute name="forceChooseFirstApiResult" required="false" description="When true, will cause the address input to automatically choose the first result when Google Geocode API returns multiple results. When false, will show an error message that multiple results were found. Default: false" %>

<%@ attribute name="colspan" required="false" description="The colspan (e.g. sm-6) of the autocomplete input and map." %>
<%@ attribute name="mapHeight" required="false" description="The height of the map." %>

<c:set var="showMap" value="${empty showMap ? 'true' : showMap}" />
<c:set var="inputInsideMap" value="${empty inputInsideMap ? 'false' : inputInsideMap}" />
<c:set var="markerInfo" value="${empty markerInfo ? 'true' : markerInfo}" />
<c:set var="forceChooseFirstApiResult" value="${empty forceChooseFirstApiResult ? 'false' : forceChooseFirstApiResult}" />
<c:set var="colspan" value="${empty colspan ? 'sm-8' : colspan}" />
<c:set var="mapHeight" value="${empty mapHeight ? '250px' : mapHeight}" />
<c:set var="overwriteInputsOnInitialize" value="${empty overwriteInputsOnInitialize ? 'true' : overwriteInputsOnInitialize}" />

<c:set var="mapId" value="${id}_map" />

<c:set var="allowedGeocodeLocationTypes" value="${fn:split(allowedGeocodeLocationTypes, ',')}" />
<c:set var="allowedGeocodeLocationTypes" value="[\"${fn:join(allowedGeocodeLocationTypes, '\",\"')}\"]" />
<c:set var="allowedGeocodeLocationTypes" value="${fn:length(allowedGeocodeLocationTypes) eq 4 ? '[]' : allowedGeocodeLocationTypes}" />

<c:set var="address1Id" value="${fn:replace(address1Path, '.' , '_')}" />
<c:set var="address2Id" value="${fn:replace(address2Path, '.' , '_')}" />
<c:set var="cityId" value="${fn:replace(cityPath, '.' , '_')}" />
<c:set var="stateId" value="${fn:replace(statePath, '.' , '_')}" />
<c:set var="zipcodeId" value="${fn:replace(zipcodePath, '.' , '_')}" />
<c:set var="countryId" value="${fn:replace(countryPath, '.' , '_')}" />
<c:set var="locationTypeId" value="${fn:replace(locationTypePath,'.' , '_')}" />
<c:set var="latitudeId" value="${fn:replace(latitudePath, '.' , '_')}" />
<c:set var="longitudeId" value="${fn:replace(longitudePath, '.' , '_')}" />

<c:set var="paths" value="${address1Path},${address2Path},${cityPath},${statePath},${zipcodePath},${countryPath},${latitudePath},${longitudePath},${locationTypePath}" />
<c:set var="paths" value="${fn:split(paths, ',')}" />

<c:set var="controlGroupId" value="${id}_control_group" />
<c:set var="inlineErrorId" value="${id}_errors" />


<c:choose>
    <c:when test="${not empty labelCode}">
        <spring:message var="label" code="${labelCode}" text="${label}" />
    </c:when>
    <c:otherwise>
        <spring:message var="label" code="${label}" text="${label}" />
    </c:otherwise>
</c:choose>
<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder}">
    <spring:message var="defaultPlaceholder" code="ux.copy.inputAddress.placeholder" text="Enter a street address" />
    <spring:message var="placeholder" code="${placeholderCode}" text="${defaultPlaceholder}" />
</c:if>

<spring:message var="buttonClearMessage" code="ux.inputAddress.buttonClear" text="" />
<spring:message var="errorNotFoundMessage" code="ux.inputAddress.errorNotFound" text="" />
<spring:message var="errorMultipleResultsMessage" code="ux.inputAddress.errorMultipleResults" text="" />

<div id="${controlGroupId}" class="form-group ${colspan}">
    <label class="control-label ${labelClass} ${required ? 'required-label' : ''}" for="${id}">
        ${label}
    </label>
    <div class="controls">
        <c:forEach var="path" items="${paths}">
            <c:set var="formattedId" value="${fn:replace(path, '.' , '_')}" />
            <form:hidden path="${path}" id="${formattedId}"/>
        </c:forEach>

        <span id="${inlineErrorId}" class="help-block hidden">
            <c:forEach var="path" items="${paths}">
                <form:errors path="${path}" />
            </c:forEach>
        </span>

        <input id="${id}" placeholder="${placeholder}" type="text" class="form-control">

        <c:if test="${showMap}">
            <edo:map id="${mapId}" canvasWidth="100%" canvasHeight="${mapHeight}; margin-top:5px" /> <%-- FIXME: inline style --%>
        </c:if>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var locationSearch = new edo.geo.LocationSearch("${id}",
                {
                  address: "${address1Id}",
                  address2: "${address2Id}",
                  city: "${cityId}",
                  state: "${stateId}",
                  postalCode: "${zipcodeId}",
                  country: "${countryId}",
                  latitude: "${latitudeId}",
                  longitude: "${longitudeId}",
                  locationType: "${locationTypeId}"
                },
                edo.tag.cache.map && edo.tag.cache.map.get("${mapId}"),
                {
                  inputInsideMap: ${inputInsideMap},
                  markerInfo: ${markerInfo},
                  forceChooseFirstResult: ${forceChooseFirstApiResult},
                  allowedGeocodeLocationTypes: ${allowedGeocodeLocationTypes},
                  overwriteInputsOnInitialize: ${overwriteInputsOnInitialize},
                  regionBias: "${pageContext.response.locale.country}",
                  messages: {
                      buttonClear: "${buttonClearMessage}",
                      errorNotFound: "${errorNotFoundMessage}",
                      errorMultipleResults: "${errorMultipleResultsMessage}"
                  }
                });

        locationSearch.on("initialize", function() {
            if ("${defaultValue}" && !locationSearch.hasLocation()) {
                locationSearch.search("${defaultValue}", { suppressChangeEvent: true });
            }
        });
    });
</script>
