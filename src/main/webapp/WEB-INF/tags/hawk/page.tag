<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%@ attribute name="pageTitle" required="true" %>
<%@ attribute name="headerTitle" required="false" description="text that appears in page h1 tag. defaults to pageTitle if not present. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself."  %>
<%@ attribute name="headerStatus" required="false" fragment="true" %>
<%@ attribute name="breadcrumbs" required="false" fragment="true" %>
<%@ attribute name="customHead" required="false" fragment="true" description="NOTE: This will be deprecated in the future to prevent adding CSS or JS to head. Only available now for migration purposes." %>
<%@ attribute name="absolutelyPositionedElements" required="false" fragment="true" %>
<%@ attribute name="bodyClass" required="false" %>
<%@ attribute name="bodyScript" required="false" fragment="true" %>

<c:choose>
    <c:when test="${headerTitle != null}">
        <c:set var="h1"><spring:message code="${headerTitle}" text="${headerTitle}" /></c:set>
    </c:when>
    <c:otherwise>
        <c:set var="h1"><spring:message code="${pageTitle}"/></c:set>
    </c:otherwise>
</c:choose>


<c:choose>
    <c:when test="${bodyClass != null}">
        <c:set var="bodyCSSAttr">class="${bodyClass}"</c:set>
    </c:when>
    <c:otherwise>
        <c:set var="bodyCSSAttr" value="" />
    </c:otherwise>
</c:choose>



<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><spring:message code="${pageTitle}"/> - <spring:message code="application.name"/></title>
    <c:import url="/WEB-INF/jsp/site/head.jsp" />

    <jsp:invoke fragment="customHead" />

</head>
<body ${bodyCSSAttr}>

<div class="container-fluid">

    <c:if test="${not empty pageLoadMessage}">
        <hawk:alertOverlay id="page_load_alert" alertType="${pageLoadMessageType}" showEvent="onPageLoad">
            <jsp:attribute name="alertContent">
                <strong><hawk:out value="${pageLoadMessage}"/></strong>
            </jsp:attribute>
        </hawk:alertOverlay>
    </c:if>

    <%@ include file="/WEB-INF/jsp/site/header.jsp"%>

    <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12" id="content">

                <jsp:invoke fragment="breadcrumbs" />

                <div class="row">
                    <div id="main-body">
                        <jsp:doBody />
                    </div>
                </div>
                <div class="row" style="background: #333">
                    <c:import url="/WEB-INF/jsp/site/footer.jsp" />
                </div>


        </div>
    </div>

    <jsp:invoke fragment="absolutelyPositionedElements" />

    <hawk:pageSupportModal />

    <c:import url="/WEB-INF/jsp/site/js.jsp" />

    <script>
        <jsp:invoke fragment="bodyScript" />

        $(document).ready(function() {
            $.EventBus("onPageLoad").publish();
        });
    </script>

</div>
</body>
</html>
