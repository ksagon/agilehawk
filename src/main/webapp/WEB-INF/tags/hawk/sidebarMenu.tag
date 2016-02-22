<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="title" required="true" description="The string or message code to be used for the menu item link text" %>
<%@ attribute name="icon" required="true" %>

<%@ attribute name="url" required="false" description="Used for the href, as well as to check view permission. View permission is evaluated as (hasUrlAccess and hasSpecialRuleAccess)." %>
<%@ attribute name="specialRule" required="false" description="Used to determine view permissions. Defaults to 'true'. View permission is evaluated as (hasUrlAccess and hasSpecialRuleAccess)." %>
<%@ attribute name="subItems" required="false" fragment="true" %>

<%@ attribute name="id" required="false" %>

<spring:message var="title" code="${title}" text="${title}" />

<c:set var="hasSubItems" value="${not empty subItems}" />
<c:set var="href">
    <c:choose>
        <c:when test="${hasSubItems}">#</c:when>
        <c:otherwise><c:url value="${url}" /></c:otherwise>
    </c:choose>
</c:set>
<c:set var="hasSpecialRuleAccess" value="${empty specialRule ? 'true' : specialRule}" />

<c:if test="${empty pageScope.id}">
    <c:set var="urlForLoop" value="${fn:contains(url, '?') ? fn:substringBefore(url, '?') : url}"/>
    <c:set var="id" value="${fn:replace(fn:replace(fn:substring(urlForLoop, 1, fn:length(urlForLoop)), '/', '_'),'#','')}"/>
</c:if>

    <li class="list-group-item">
        <a id="${id}" title="${title}" href="${href}" <c:if test="${hasSubItems}">data-toggle="collapse" data-parent="#sidebar-nav" data-target="#${id}-${icon}"</c:if>>
            <i class="fa fa-${icon} fa-fw"></i>
            <span>${title}</span>
        </a>
        <c:if test="${hasSubItems}">
        <ul id="${id}-${icon}" class="collapse">
            <jsp:invoke fragment="subItems" />
        </ul>
        </c:if>
    </li>
