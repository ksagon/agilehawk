<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<%@ attribute name="action" required="true" type="com.edo.marketing.ui.grid.action.GridRowAction" %>
<%@ attribute name="model" required="true" type="com.edo.marketing.ui.model.Model" %>
<%@ attribute name="gridId" required="true" %>
<%@ attribute name="baseUrl" required="true" %>

<%@ attribute name="isActionSetMember" required="false" %>

<c:set var="actionUrl" value="${baseUrl}/${gridId}/action/${action.action}?id=${model.id}" />

<mp:gridRowActionBase model="${model}" actionUrl="${actionUrl}" action="${action}" isActionSetMember="${isActionSetMember}">
    <jsp:attribute name="actionContent">
    <spring:message var="title" code="${action.displayName}" text="${action.displayName}"/>
        <a class="fa fa-${action.icon} ${action.cssClass} tip-top" data-container='body' title="${title}"
                onclick="javascript:ajaxLoadModal('<c:url value="${actionUrl}" />','${action.name}_container','${action.name}_modal')"></a>
    </jsp:attribute>
</mp:gridRowActionBase>