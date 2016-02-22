<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ attribute name="treeId" required="true" %>
<%@ attribute name="actionType" required="true" description="Valid values include CREATE_NODE, DELETE_NODE" %>
<%@ attribute name="modalUrl" required="true" %>
<%@ attribute name="actionEvent" required="true" description="The EventBus event name that will trigger the action to be taken on the tree. This event should be published by the modal's button action." %>
<%@ attribute name="label" required="false" description="Text for the button. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>

<c:url var="modalFullUrl" value="${modalUrl}" />

<c:set var="actionId" value="${treeId}_${fn:toLowerCase(actionType)}" />
<c:set var="modalId" value="${treeId}_modal" />

<c:choose>
    <c:when test="${not empty labelCode}">
        <spring:message var="label" code="${labelCode}" text="${label}" />
    </c:when>
    <c:otherwise>
        <spring:message var="label" code="${label}" text="${label}" />
    </c:otherwise>
</c:choose>

<sec:authorize url="${modalUrl}">
    <a id="${actionId}" class="btn btn-default">
        ${label}
    </a>
    
    <script type="text/javascript">
        $(document).ready(function() {
            $.EventBus("treeLoaded").subscribe(function(treeContainer) {
                if (treeContainer.get(0).id === "${treeId}") {
                    edo.tree.registerModalAction(treeContainer, edo.tree.ActionType["${actionType}"], "${actionEvent}", "${actionId}",
                                                 "${modalId}", "${modalFullUrl}");
                }
            });
        });
    </script>
</sec:authorize>
