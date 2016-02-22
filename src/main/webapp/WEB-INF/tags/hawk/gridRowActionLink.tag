<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<%@ attribute name="action" required="true" type="com.edo.marketing.ui.grid.action.GridRowAction" %>
<%@ attribute name="model" required="true" type="com.edo.marketing.ui.model.Model" %>

<%@ attribute name="isActionSetMember" required="false" %>

<spring:url var="actionUrl" value="${action.link}" context="/">
    <c:forEach var="templateVar" items="${edofn:getUrlTemplateVariableNames(action.link)}">
        <spring:param name="${templateVar}" value="${model[templateVar]}" />
    </c:forEach>
</spring:url>
<c:set var="actionUrl" value="${fn:replace(actionUrl, '//', '/')}" />

<mp:gridRowActionBase model="${model}" actionUrl="${actionUrl}" action="${action}" isActionSetMember="${isActionSetMember}">
    <jsp:attribute name="actionContent">
        <spring:message var="title" code="${action.displayName}" text="${action.displayName}"/>
        <a class="fa fa-${action.icon} ${action.cssClass} tip-top" data-container='body' title="${title}"
                href="<c:url value="${actionUrl}"/>"><span class="sr-only">${title}</span></a>
    </jsp:attribute>
</mp:gridRowActionBase>
