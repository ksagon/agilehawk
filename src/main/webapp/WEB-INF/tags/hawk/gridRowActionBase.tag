<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<%@ attribute name="actionContent" required="true" fragment="true" %>

<%@ attribute name="action" required="true" type="com.edo.marketing.ui.grid.action.GridRowAction" %>
<%@ attribute name="actionUrl" required="true" %>
<%@ attribute name="model" required="true" type="com.edo.marketing.ui.model.Model" %>

<%@ attribute name="isActionSetMember" required="false" %>

<c:set var="isActionChosen" value="${empty isActionChosen ? 'false' : isActionChosen}" scope="request" />
<c:set var="isListItemDrawn" value="${empty isListItemDrawn ? 'false' : isListItemDrawn}" scope="request" />

<c:if test="${not isActionChosen}">
    <sec:authorize url="${actionUrl}">
        <c:choose>
            <c:when test="${not isListItemDrawn}">
                <c:set var="displayName" value="${action.displayName}"/>
                <c:set var="className" value="${fn:replace(displayName, ' ', '-')}"/>
                <li class="${fn:toLowerCase(className)}">
                    <c:if test="${edofn:isActionEnabled(action, model)}">
                        <c:set var="isActionChosen" value="${true}" scope="request" />
                        
                        <jsp:invoke fragment="actionContent" />
                    </c:if>
                    <c:set var="isListItemDrawn" value="${true}" scope="request" />
                </li>
            </c:when>
            <c:otherwise>
                <c:if test="${edofn:isActionEnabled(action, model)}">
                    <c:set var="isActionChosen" value="${true}" scope="request" />
                    
                    <jsp:invoke fragment="actionContent" />
                </c:if>
            </c:otherwise>
        </c:choose>
    </sec:authorize>
</c:if>

<c:if test="${not isActionSetMember}">
    <c:set var="isActionChosen" value="${false}" scope="request" />
    <c:set var="isListItemDrawn" value="${false}" scope="request" />
</c:if>