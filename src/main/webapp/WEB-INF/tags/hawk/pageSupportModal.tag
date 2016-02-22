<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ tag description="This tag adds support to a page for easy usage of modals loaded into the page via AJAX. In specific,
                     it adds a div id='default_modal_container' where all modal DOM will be inserted after
                     retrieval via AJAX by the edo.modal.loadAjax() function. If the loading of content
                     via AJAX fails, this tag contains a modal with an error message that will show instead.
                     This tag utilizes two messages from the message bundle: ux.modal.errorLoading.title
                     and ux.modal.errorLoading.text. This tag is included in &lt;hawk:page&gt;." %>

<div id="default_modal_container"></div>
<spring:message var="modalHeader" code="ux.modal.errorLoading.title" text="Error loading content" />
<hawk:infoModal id="error_loading_modal" modalHeader="${modalHeader}">
    <jsp:attribute name="content">
        <div class="alert alert-danger">
            <spring:message code="ux.modal.errorLoading.text" text="There was an error loading your content. Please try again later." />
        </div>
    </jsp:attribute>
</hawk:infoModal>
