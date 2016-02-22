<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="objectType" required="true" description="string or message code for objectType (injected into default delete confirmation message)"  %>
<%@ attribute name="objectName" required="true"%>
<%@ attribute name="deleteUrl" required="true" %>

<%@ attribute name="onDeleteEvent" required="false" %>
<%@ attribute name="eventData" required="false" %>
<%@ attribute name="message" required="false" description="String or message code for modal body" %>

<c:url var="deleteUrl" value="${deleteUrl}" />
<spring:message var="objectType" code="${objectType}" text="${objectType}" />
<spring:message var="modalHeader" code="ux.heading.deleteActionModal"
                text="Confirm ${objectType} Deletion" arguments="${objectType}" />

<hawk:modal id="${id}" modalHeader="${modalHeader}">
    <jsp:attribute name="content">
        <c:choose>
            <c:when test="${empty message}">
                <spring:message code="ux.copy.confirmDeletion"
                                text="Are you sure you want to delete the ${objectType} ${objectName}?" arguments="${objectType},${objectName}" />
            </c:when>
            <c:otherwise>
                <spring:message code="${message}" arguments="${objectType},${objectName}"
                                text="${message}" />
            </c:otherwise>
        </c:choose>
        <span class="help-block hidden"></span>
    </jsp:attribute>
    <jsp:attribute name="buttons">
        <button id="${id}_cancel_btn" class="btn btn-link" data-dismiss="modal">
            <spring:message code="ux.action.cancel" text="Cancel" />
        </button>
        <button id="${id}_confirm_btn" class="btn btn-danger" onclick="edo.modal.deleteAction['${id}']();">
            <spring:message code="ux.action.delete" text="Delete ${objectType}" arguments="${objectType}" />
        </button>
    </jsp:attribute>
</hawk:modal>
<script type="text/javascript">
edo.modal.deleteAction = edo.modal.deleteAction || {};
edo.modal.deleteAction["${id}"] = function() {
    var modal = edo.util.getElement("${id}");    
    $.ajax({
        url: "${deleteUrl}",
        type: "DELETE",
        success: function(response) {
            edo.form.processFormResponse(response, modal, modal, function() {
                modal.modal("hide");
                $.EventBus("${onDeleteEvent}").publish("${eventData}");
            });
        }
    });
};
</script>