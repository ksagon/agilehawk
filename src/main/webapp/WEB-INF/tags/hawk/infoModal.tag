<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" description="Modal element ID." %>
<%@ attribute name="modalHeader" required="true" description="String or message code to be displayed as modal header" %>
<%@ attribute name="content" required="true" description="HTML to include in modal body." %>

<hawk:modal id="${id}" modalHeader="${modalHeader}" content="${content}">
    <jsp:attribute name="buttons">
         <button class="btn" data-dismiss="modal">
             <spring:message code="ux.action.close" text="Close" />
         </button>
    </jsp:attribute>
</hawk:modal>
