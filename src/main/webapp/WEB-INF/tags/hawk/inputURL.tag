<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ attribute name="path" required="true" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="id" required="false" description="If empty, the element's path attribute will be used for its id attribute" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="defaultUrlProtocol" required="false" description="Valid values are 'http' or 'https'; defaults to 'http'"%>

<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<c:set var="defaultUrlProtocol" value="${defaultUrlProtocol eq 'https' ? 'https' : 'http'}" />
<c:set var="id" value="${empty pageScope.id ? path : pageScope.id}" />

<edo:inputBase path="${path}" id="${id}" label="${label}" labelCode="${labelCode}" required="${required}" controlGroupClass="input-url ${controlGroupClass}" labelClass="${labelClass}"
               readonly="${readonly}" inputOnly="${inputOnly}" colspan="${colspan}">
    <jsp:attribute name="inputField">
        <div class="input-group">
            <span id="add_on_${path}" class="input-group-addon">${defaultUrlProtocol}://</span>
            <input id="display_${id}" class="${inputClass} form-control" type="text" value="<spring:bind path="${path}">${status.value}</spring:bind>" />
        </div>
        <form:hidden path="${path}" id="${id}" />
    </jsp:attribute>
</edo:inputBase>
<script>
$(document).ready(function() {

    var HTTP = "http://";
    var HTTPS = "https://";

    var display${id} = $("#display_${id}");
    var real${id} = $("#${id}");
    var addOn${id} = $("#add_on_${id}");

    function update${id}() {
        var displayValue = $.trim(display${id}.val());

        if (!displayValue) {
            real${id}.val("");
            return;
        }

        if (displayValue.indexOf(HTTP) === 0) {
            real${id}.val(displayValue).trigger("change");
            display${id}.val(displayValue.substring(HTTP.length));
            addOn${id}.html(HTTP);
        } else if (displayValue.indexOf(HTTPS) === 0) {
            real${id}.val(displayValue).trigger("change");
            display${id}.val(displayValue.substring(HTTPS.length));
            addOn${id}.html(HTTPS);
        } else {
            real${id}.val(addOn${id}.html() + displayValue).trigger("change");
            display${id}.val(displayValue);
        }
    }

    update${id}();

    display${id}.change(update${id});
});
</script>
