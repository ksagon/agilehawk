<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="dataUrl" required="true" description="Path to retrieve initial tree data via AJAX. E.g. '/employees/hierarchyNodes'" %>

<%@ attribute name="actions" required="false" fragment="true" %>
<%@ attribute name="actionsTip" required="false" description="text that appears below actions. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself."  %>
<%@ attribute name="types" type="java.lang.Enum[]" required="false" description="A collection/array of enum values, each of which must implement a getIcon() method that returns the icon class to be used for its node (e.g. 'fa fa-user')." %>
<%@ attribute name="defaultIcon" required="false" description="The class of the default icon to show next to each node (e.g. 'fa fa-user')." %>

<%@ attribute name="treeClass" required="false" %>
<%@ attribute name="height" required="false" %>
<%@ attribute name="maxHeight" required="false" %>

<spring:message var="actionsTip" code="${actionsTip}" text="${actionsTip}" />

<c:url var="dataUrl" value="${dataUrl}" />
<c:set var="defaultIcon" value="${empty defaultIcon ? 'fa fa-folder-o' : defaultIcon}" />

<c:set var="heightStyle" value="${not empty height ? 'height:' : '' }${height}" />
<c:set var="maxHeightStyle" value="${not empty maxHeight ? 'max-height:' : '' }${maxHeight}" />

<c:if test="${not empty actions}">
    <div id="${id}_actions">
        <jsp:invoke fragment="actions" />
    </div>
    <c:if test="${not empty actionsTip}">
        <small class="text-muted"><c:out value="${fn:trim(actionsTip)}" /></small>
    </c:if>
</c:if>
<div id="${id}" class="${treeClass}" style="${maxHeightStyle} ${heightStyle}"></div>

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
    "types": ${jsTypes},
    "multiple": false
}
</c:set>

<script type="text/javascript">
$(document).ready(function() {
    edo.tree.create("${id}",
                    "${dataUrl}",
                    function(node) {
                        return node.id !== "#" ? { parentValue: node.li_attr.value } : null;
                    },
                    null,
                    ${jsOptions}
    );
});
</script>