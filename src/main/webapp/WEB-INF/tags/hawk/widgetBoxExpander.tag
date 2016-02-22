<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="title" required="false" description="Text for the heading of the widget box. Attempts to use the provided title as a message code for the i18n message bundle, and falls back to using the title itself. " %>
<%@ attribute name="titleCode" required="false" description="Deprecated. Use the 'title' attribute instead." %>
<%@ attribute name="defaultState" required="false" %>
<%@ attribute name="widgetPanelClass" required="false" %>
<%@ attribute name="widgetContentClass" required="false" %>
<%@ attribute name="widgetFooterContent" required="false" fragment="true" %>

<c:choose>
    <c:when test="${not empty titleCode}">
        <spring:message var="title" code="${titleCode}" text="${title}" />
    </c:when>
    <c:otherwise>
        <spring:message var="title" code="${title}" text="${title}" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${widgetPanelClass != null}">
        <c:set var="panelClass" value="${widgetPanelClass}" />
    </c:when>
    <c:otherwise>
        <c:set var="panelClass" value="panel-default" />
    </c:otherwise>
</c:choose>

<c:set var="expanderClass" value="in" />
<c:choose>
    <c:when test="${defaultState == 'closed'}">
        <c:set var="expanderClass" value="collapse" />
    </c:when>
    <c:otherwise>
        <c:set var="expanderClass" value="in" />
    </c:otherwise>
</c:choose>


<div class="panel collapsible ${panelClass}">
    <div class="panel-heading" data-toggle="collapse" data-target="#${id}-c">
        <h5><a>${title}</a></h5>
    </div>
    <div id="${id}-c" class="${expanderClass}">
        <div>
            <div id="${id}" class="panel-body clearfix ${widgetContentClass}">
                <jsp:doBody />
            </div>
        </div>

        <c:if test="${not empty widgetFooterContent}">
            <div class="panel-footer clearfix"><jsp:invoke fragment="widgetFooterContent" /></div>
        </c:if>
    </div>
</div>
