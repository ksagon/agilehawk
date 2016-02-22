<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" description="Modal element ID" %>
<%@ attribute name="modalHeader" required="true" description="String or message code to be displayed as modal header" %>
<%@ attribute name="content" required="true" description="HTML to include in modal body." %>
<%@ attribute name="primaryButtonName" required="true" description="String or message code for main action button label." %>
<%@ attribute name="primaryButtonAction" required="true" description="JavaScript to call on primary button click." %>
<%@ attribute name="primaryButtonClass" required="false" description="Additional class(es) to be added to primary button. Required: false" %>
<%@ attribute name="secondaryButtonName" required="true" description="String or message code for secondary action button label." %>
<%@ attribute name="secondaryButtonAction" required="true" description="JavaScript to call on secondary button click." %>
<%@ attribute name="secondaryButtonClass" required="false" description="Additional class(es) to be added to secondary button. Required: false" %>

<spring:message var="primaryButtonName"  code="${primaryButtonName}" text="${primaryButtonName}" />
<spring:message var="secondaryButtonName" code="${secondaryButtonName}" text="${secondaryButtonName}" />

<hawk:modal id="${id}" modalHeader="${modalHeader}" content="${content}">
    <jsp:attribute name="buttons">
        <button class="btn btn-link" data-dismiss="modal">
            <spring:message code="ux.action.cancel" text="Cancel" />
        </button>
        <button class="btn ${secondaryButtonClass}" onclick="${secondaryButtonAction}">${secondaryButtonName}</button>
        <button class="btn btn-success ${primaryButtonClass}" onclick="${primaryButtonAction}">${primaryButtonName}</button>
    </jsp:attribute>
</hawk:modal>