<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="path" required="true" %>

<%@ attribute name="label" required="false" description="Applies a label to the input. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="multiple" required="false" %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>
<%@ attribute name="ajaxUrl" required="true" %>
<%@ attribute name="currentValuesAsString" required="true" %>
<%@ attribute name="minCharacters" required="true" %>

<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>
<c:url var="ajaxUrlPath" value="${ajaxUrl}" />
<c:set var="select2class" value="bigdrop" />

<c:set var="currentValue">
    <spring:bind path="${path}">${edofn:toJSON(status.actualValue)}</spring:bind>
</c:set>

<edo:inputBase path="${path}" required="${required}" colspan="${colspan}" label="${label}" readonly="${readonly}">
    <jsp:attribute name="inputField">
        <form:hidden id="${path}" path="${path}" class="${select2class}"/>
    </jsp:attribute>
</edo:inputBase>

<script type="text/javascript">
    $(function() {
        $("#" + "${path}").select2({
            placeholder: "${placeholder}",
            multiple: ${multiple},
            closeOnSelect:false,
            minimumInputLength: ${minCharacters},
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "${ajaxUrlPath}",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        nameFragment: term // search term
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    // since we are using custom formatting functions we do not need to alter remote JSON data
                    return {results: data};
                }
            },
            formatResult: ${path}FormatResult, // omitted for brevity, see the source of this page
            formatSelection: ${path}FormatSelection,  // omitted for brevity, see the source of this page
            initSelection: function(element, callback) {
                var data = [];
                $(element.val().split(",")).each(function(i) {
                    var item = this.split(':');
                    data.push({
                        id: item[0],
                        name: item[1]
                    });
                });
                callback(data);
            },
            dropdownCssClass: "${select2class}", // apply css that makes the dropdown taller
            escapeMarkup: function (m) { return m; } // we do not want to escape markup since we are displaying html in results
        });

        if('${currentValuesAsString}'.length > 0) {
            $("#" + "${path}").select2('val', '${currentValuesAsString}'.split(','));  // expecting string in format of "<id>:<name>,<id>:<name>,..."
        } else {
            $("#" + "${path}").select2('val', '');
        }
    });

    function ${path}FormatResult(item) {
        return item.name;
    }

    function ${path}FormatSelection(item) {
        return item.name;
    }
</script>