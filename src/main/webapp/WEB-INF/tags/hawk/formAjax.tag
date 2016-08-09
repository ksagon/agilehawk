<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" rtexprvalue="true" %>
<%@ attribute name="modelAttribute" required="true" rtexprvalue="true" %>
<%@ attribute name="actionUrl" required="true" rtexprvalue="true" %>
<%@ attribute name="layout" required="true" description="Valid values are 'horizontal', 'vertical', 'left-align', and 'navbar'" %>

<%@ attribute name="onSuccess" required="false" rtexprvalue="true" description="JavaScript function, no () necessary" %>
<%@ attribute name="cssClass" required="false" %>

<c:set var="onSuccess" value="${empty onSuccess ? 'null' : onSuccess}" />
<spring:url var="formUrl" value="${actionUrl}" />

<hawk:formBase id="${id}" modelAttribute="${modelAttribute}" actionUrl="${actionUrl}" layout="${layout}" cssClass="${cssClass}">
    <jsp:doBody />
</hawk:formBase>
<script>
	rsp = function(formResponse) {
        if (typeof ${onSuccess} === "function") {
            hawk.util.call(${onSuccess}, this, formResponse);
        }
    }

    new hawk.form.Form("${id}", "${formUrl}", rsp);
</script>
