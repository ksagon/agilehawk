<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" rtexprvalue="true" %>
<%@ attribute name="modelAttribute" required="true" rtexprvalue="true" %>
<%@ attribute name="actionUrl" required="true" rtexprvalue="true" %>
<%@ attribute name="validateUrl" required="true" rtexprvalue="true" %>
<%@ attribute name="layout" required="true" description="Valid values are 'horizontal', 'vertical', 'left-align', and 'navbar'" %>
<%@ attribute name="method" required="false" %>

<%@ attribute name="cssClass" required="false" %>

<spring:url var="formUrl" value="${validateUrl}" />

<hawk:formBase id="${id}" modelAttribute="${modelAttribute}" actionUrl="${actionUrl}" layout="${layout}" cssClass="${cssClass}" method="${method}">
    <jsp:doBody />
</hawk:formBase>
<script>
    new hawk.form.Form("${id}", "${formUrl}", "submit");
</script>
