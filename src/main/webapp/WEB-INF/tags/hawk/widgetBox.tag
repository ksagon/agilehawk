<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%--<%@ attribute name="id" required="false" %>--%>
<%@ attribute name="title" required="false" description="Text for the heading of the widget box. Attempts to use the provided title as a message code for the i18n message bundle, and falls back to using the title itself. " %>
<%@ attribute name="titleCode" required="false" description="Deprecated. Use the 'title' attribute instead." %>
<%@ attribute name="widgetContentId" required="false" %>
<%@ attribute name="widgetPanelClass" required="false" %>
<%@ attribute name="widgetContentClass" required="false" %>
<%@ attribute name="widgetFooterContent" required="false" fragment="true" %>

<c:set var="panelClass" value="${empty widgetPanelClass ? 'panel-default' : widgetPanelClass}" />

<c:choose>
    <c:when test="${not empty titleCode}">
        <spring:message var="title" code="${titleCode}" text="${title}" />
    </c:when>
    <c:otherwise>
        <spring:message var="title" code="${title}" text="${title}" />
    </c:otherwise>
</c:choose>

<div class="panel ${panelClass}">
    <c:if test="${not empty title}">
        <div class="panel-heading">
            <h5>${title}</h5>
        </div>
    </c:if>

    <c:set var="contentIdAttr">
        <c:if test="${not empty widgetContentId}">id="${widgetContentId}"</c:if>
    </c:set>
    <div ${contentIdAttr} class="panel-body clearfix ${widgetContentClass}">
        <jsp:doBody />
    </div>

    <c:if test="${not empty widgetFooterContent}">
        <div class="panel-footer clearfix"><jsp:invoke fragment="widgetFooterContent" /></div>
    </c:if>
</div>
