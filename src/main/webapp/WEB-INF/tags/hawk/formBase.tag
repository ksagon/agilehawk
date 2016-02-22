<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" rtexprvalue="true" %>
<%@ attribute name="modelAttribute" required="true" rtexprvalue="true" %>
<%@ attribute name="actionUrl" required="true" rtexprvalue="true" %>
<%@ attribute name="layout" required="true" description="Valid values are 'horizontal', 'vertical', 'inline', 'left-align', and 'navbar'" %>

<%@ attribute name="cssClass" required="false" %>

<c:set var="layout">
    <c:if test="${layout eq 'navbar'}">navbar-form</c:if>
    <c:if test="${layout ne 'navbar'}">form-${layout}</c:if>
</c:set>

<spring:url value="${actionUrl}" var="action" />
<form:form modelAttribute="${modelAttribute}" id="${id}" action="${action}" cssClass="${layout} ${cssClass}" method="post" role="form">
    <c:set var="_formId" value="${id}" scope="request" />
    <form:errors id="${id}_errors" path="" cssClass="alert alert-danger" element="div" htmlEscape="false"/>
    <div class="sr-only sr-validation" tabindex="-1" id="${id}_errors_sr" title="<spring:message code="ux.heading.form.accessibleMessages" />"></div>
    <jsp:doBody />
    <c:remove var="_formId" />
</form:form>
