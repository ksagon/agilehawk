<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="title" required="true" description="The string or message code to be used for the page title and header title" %>
<spring:message var="title" code="${title}" text="${title}" />

<%-- TODO deprecate this tag?? --%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>${title} - <spring:message code="application.name"/></title>

    <c:import url="/WEB-INF/jsp/site/headCss.jsp" />

</head>
<body>

<div class="container">

    <div class="row" id="header">

        <div class="col-md-2 col-sm-2">
            <h1 class="logo-h1">
                <a href="<c:url value='/'/>"><spring:message code="heading.logoH1" text="edo Marketplace" /></a>
            </h1>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-1 col-md-3 col-lg-2" id="sidebar">
            <c:import url="/WEB-INF/jsp/site/sidebar.jsp" />
        </div>
        <div class="col-sm-11 col-md-9 col-lg-10" id="content">

            <div class="row" id="content-header">
                <div class="col-xs-12 col-md-8">
                    <h1>${title}</h1>
                </div>
            </div>

            <div class="row">
                <div id="main-body">
                    <div class="panel panel-default col-sm-8 col-lg-6">
                        <div class="panel-body">
                            <jsp:doBody />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="background: #333">
                <c:import url="/WEB-INF/jsp/site/footer.jsp" />
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/jsp/site/js.jsp" />
</div>
</body>
</html>
