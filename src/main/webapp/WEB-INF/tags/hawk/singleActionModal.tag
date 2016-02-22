<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" description="Modal element ID" %>
<%@ attribute name="modalHeader" required="true" description="String or message code to be displayed as modal header" %>
<%@ attribute name="content" required="true" description="HTML to include in modal body." %>
<%@ attribute name="buttonName" required="true" description="String or message code for main action button label." %>
<%@ attribute name="buttonAction" required="true" description="JavaScript to call on button click." %>

<spring:message var="buttonName"  code="${buttonName}" text="${buttonName}" />

<edo:modal id="${id}" modalHeader="${modalHeader}" content="${content}">
    <jsp:attribute name="buttons">
        <button id="cancel_${id}" class="btn btn-link" data-dismiss="modal">
            <spring:message code="ux.action.cancel" text="Cancel" />
        </button>
        <button id="submit_${id}" class="btn btn-success">${buttonName}</button>
    </jsp:attribute>
</edo:modal>

<script>
    edo.util.getElement("submit_${id}").click(function () {
        var submitButtonWidth = $(this).width();
        $(this).addClass("disabled");
        $(this).width(submitButtonWidth);
        $(this).html("<i class='fa fa-spinner fa-spin'></i>");
    }).click(function () {
        ${buttonAction}
    });

    $.EventBus("afterFormAjaxSubmitted").subscribe(function() {
        $.EventBus("modalActionComplete").publish();
    });

    $.EventBus("modalActionComplete").subscribe(function() {
        var button = edo.util.getElement("submit_${id}");
        button.removeClass("disabled");
        button.html("${buttonName}");
    });
</script>
