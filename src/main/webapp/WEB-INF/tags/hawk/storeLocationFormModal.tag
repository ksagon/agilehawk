<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="storeLocationPath" required="true" %>
<%@ attribute name="actionUrl" required="true" %>
<%@ attribute name="modalHeader" required="true" %>
<%@ attribute name="buttonName" required="true" %>

<%@ attribute name="updateGrid" required="false" %>

<c:set var="formId">${id}_form</c:set>

<edo:singleActionModal id="${id}" modalHeader="${modalHeader}" buttonName="${buttonName}" buttonAction="$('#${formId}').submit();">
    <jsp:attribute name="content">
        <edo:formAjax id="${formId}" modelAttribute="${storeLocationPath}" actionUrl="${actionUrl}" onSuccess="storeLocationSaved" layout="vertical">
            <form:hidden path="advertiserId" />
            <form:hidden path="id" />

            <div class="row">
                <edo:inputText path="storeName" label="Location Name" required="true" colspan="sm-8" />
                <edo:inputText path="storeNumber" label="Location Number" required="true" colspan="sm-4" />
            </div>
            <div class="row">
                <edo:inputText path="address1" label="Address" required="true" placeholderText="Address 1" />
                <edo:inputText path="address2" label="Address 2" labelClass="invisible" required="false" placeholderText="Address 2" />
            </div>
            <div class="row">
                <edo:inputText path="city" label="City" required="true" />
                <edo:inputState path="state" label="State" required="true" />
                <edo:inputText path="zipcode" label="Zipcode" required="true" />
            </div>

            <h5>Store Contact</h5>
            <div class="row">
                <edo:inputText path="contactFirstName" label="First Name" required="true" />
                <edo:inputText path="contactLastName" label="Last Name" required="true" />
                <edo:inputText path="contactPhoneNumber" label="Phone Number" required="true" />
            </div>
        </edo:formAjax>
    </jsp:attribute>
</edo:singleActionModal>
<script type="text/javascript">
    function storeLocationSaved() {
        $("#${id}").modal("hide");
        <c:if test="${not empty updateGrid}">
            $.EventBus("${updateGrid}").publish();
        </c:if>
    }
</script>