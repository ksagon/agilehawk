<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="modalHeader" required="true" description="String or message code to be displayed as modal header" %>
<%@ attribute name="content" required="true" %>
<%@ attribute name="buttons" required="true" %>

<spring:message var="modalHeader" code="${modalHeader}" text="${modalHeader}"/>

<div id="${id}" class="modal fade" role="dialog" aria-labelledby="${id}Label" aria-hidden="true" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;<span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="${id}Label">${modalHeader}</h4>
            </div>
            <div class="modal-body">
                ${content}
            </div>
            <div class="modal-footer">
                ${buttons}
            </div>
        </div>
    </div>
</div>