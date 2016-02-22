<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="partnerPath" required="true" %>
<%@ attribute name="actionUrl" required="true" %>
<%@ attribute name="modalHeader" required="true" description="String or message code to be displayed as modal header" %>
<%@ attribute name="buttonName" required="true" description="String or message code for main action button label." %>

<%@ attribute name="updateGrid" required="false" %>

<edo:singleActionModal buttonName="${buttonName}" modalHeader="${modalHeader}" buttonAction="$('#save_partner_form').submit();" id="${id}">
    <jsp:attribute name="content">
        <edo:formAjax actionUrl="${actionUrl}" modelAttribute="${partnerPath}" onSuccess="partnerSaved" id="save_partner_form" layout="vertical">
            <form:hidden path="id" />
            <div class="row">
                <edo:inputText label="label.companyName" path="displayName" required="true" />
            </div>
            <div class="row">
                <edo:inputText label="label.businessAddress" path="address1" placeholder="label.address1" />
                <edo:inputText label="label.businessAddress2" labelClass="invisible" path="address2" placeholder="label.address2" />
            </div>
            <div class="row">
                <edo:inputText label="label.city" path="city" />
                <edo:inputText label="label.state" path="state" colspan="xs-4 sm-2" />
                <edo:inputText label="label.postalCode" path="zipcode" colspan="xs-8 sm-4" />
            </div>
            <div class="row">
                <edo:inputText label="label.businessPhone" path="phoneNumber" required="true" />
            </div>
            <div class="row">
                <edo:inputURL label="label.website" path="website" />
            </div>
            <h5><spring:message code="heading.partnerFormModal.primaryContact" /></h5>
            <div class="row">
                <edo:inputText label="label.firstName" path="contactFirstName" />
                <edo:inputText label="label.lastName" path="contactLastName" />
                <edo:inputEmail label="label.emailAddress" path="contactEmail" />
            </div>
        </edo:formAjax>
    </jsp:attribute>
</edo:singleActionModal>
<script type="text/javascript">
    function partnerSaved() {
        $("#${id}").modal("hide");
        <c:if test="${not empty updateGrid}">$.EventBus("${updateGrid}").publish();</c:if>
    }
</script>