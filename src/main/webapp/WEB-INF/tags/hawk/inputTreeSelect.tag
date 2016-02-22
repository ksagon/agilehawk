<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="dataUrl" required="true" description="Path to retrieve initial tree data via AJAX. E.g. '/employees/hierarchyNodes'" %>

<%@ attribute name="types" type="java.lang.Enum[]" required="false" description="A collection/array of enum values, each of which must implement a getIcon() method that returns the icon class to be used for its node (e.g. 'fa fa-user')." %>
<%@ attribute name="defaultIcon" required="false" description="The class of the default icon to show next to each node (e.g. 'fa fa-user')." %>

<%@ attribute name="treeClass" required="false" %>
<%@ attribute name="height" required="false" %>
<%@ attribute name="maxHeight" required="false" %>

<%@ attribute name="label" required="false" description="Applies a label to the tree select. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<c:url var="dataUrl" value="${dataUrl}" />
<c:set var="defaultIcon" value="${empty defaultIcon ? 'fa fa-folder-o' : defaultIcon}" />

<c:set var="heightStyle" value="${not empty height ? 'height:' : '' }${height}" />
<c:set var="maxHeightStyle" value="${not empty maxHeight ? 'max-height:' : '' }${maxHeight}" />

<c:set var="value"><spring:bind path="${path}">${status.actualValue}</spring:bind></c:set>

<edo:inputBase path="${path}" label="${label}" labelCode="${labelCode}" required="${required}" controlGroupClass="${controlGroupClass}"
               labelClass="${labelClass}" inputOnly="${inputOnly}" colspan="${colspan}"
               popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}"
               readonly="false">
    <jsp:attribute name="inputField">
        <div id="${path}_tree" class="input-tree ${treeClass} ${readonly ? '' : 'form-control'}"
             style="${maxHeightStyle} ${heightStyle}"></div>
        <c:if test="${not readonly}">
            <form:hidden path="${path}" />
        </c:if>
    </jsp:attribute>
</edo:inputBase>

<edo:treeNodeTypeAndFeaturesMap var="typeAndFeaturesMap" types="${types}" />
<c:set var="jsTypes">
{
<c:forEach items="${typeAndFeaturesMap}" var="type">
    "${type.key}": {
        <c:forEach items="${type.value}" var="feature" varStatus="status">
            "${feature.key}": "${feature.value}" ${status.last ? '' : ','}
        </c:forEach>
    },
</c:forEach>
"default": { "icon": "${defaultIcon}" }
}
</c:set>
<c:set var="jsOptions">
{
    <c:if test="${not readonly}">
        "boundInput": $("#${path}"),
    </c:if>
    "types": ${jsTypes},
    "multiple": false
}
</c:set>

<script type="text/javascript">
$(document).ready(function() {
    var readonly = ${readonly ? 'true' : 'false'};
    edo.tree.create("${path}_tree",
                    "${dataUrl}",
                    function(node) {
                        var params = {};
                        if (node.id !== "#") {
                            params.parentValue = node.li_attr.value;
                        }
                        else if ("${value}") {
                            params.selectedValue = "${value}";
                        }
                        return params;
                    },
                    function(nodes) {
                        for (var i=0; i<nodes.length; i++) {
                            if (readonly) {
                                nodes[i].state ? nodes[i].state.disabled = true : nodes[i].state = { disabled: true };
                            }
                        }
                    },
                    ${jsOptions}
    );
});
</script>
