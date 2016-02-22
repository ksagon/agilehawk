<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ tag description="A page tag containing no top navigation or sidebar. It pulls in the footer from the parent application. There is a single widget box for holding a login form and an alert-info for holding secondary content." %>

<%@ attribute name="pageTitle" required="true"
              description="Message code required. Title used in the head title tag and heading in the main content box." %>
<%@ attribute name="secondaryContent" required="false"
			  description="Secondary content to include above the footer." %>
<%@ attribute name="bodyScript" required="false" fragment="true"
              description="JavaScript to include at the bottom of the page body." %>



<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><spring:message code="${pageTitle}"/> - <spring:message code="application.name"/></title>
    <c:import url="/WEB-INF/jsp/site/headCss.jsp" />


</head>
<body id="pageLogin">

<div class="container">

    <c:if test="${not empty pageLoadMessage}">
        <edo:alertOverlay id="page_load_alert" alertType="${pageLoadMessageType}" showEvent="onPageLoad">
            <jsp:attribute name="alertContent">
                <strong>${pageLoadMessage}</strong>
            </jsp:attribute>
        </edo:alertOverlay>
    </c:if>

    <div class="row"  id="header">
        <div class="col-xs-12">
            <h1 class="logo-h1">
                <spring:message code="application.name"/>
            </h1>
        </div>
    </div>

    <div class="row loginContent">
        <div class="col-xs-10 col-xs-offset-1 col-sm-5 col-sm-offset-4 col-md-4">
            <edo:widgetBox title="${pageTitle}">
                <jsp:doBody />
            </edo:widgetBox>
        </div>
    </div>  
           
    <c:if test="${not empty secondaryContent}">
		<div class="row alert alert-info" id="secondary-content" style="margin-bottom:0px">		
			${secondaryContent}
    	</div> 
    </c:if>
    
    <div class="row loginFooter">
        <c:import url="/WEB-INF/jsp/site/footer.jsp" />
    </div>

</div>

    <c:import url="/WEB-INF/jsp/site/js.jsp" />

    <script>
        <jsp:invoke fragment="bodyScript" />

        $(document).ready(function() {
            $.EventBus("onPageLoad").publish();
        });
    </script>

</body>
</html>
