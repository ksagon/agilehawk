<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<div class="row" id="header">

    <div class="col-md-2 col-sm-2">
        <h1 class="logo-h1">
            <a href="<c:url value='/'/>"><spring:message code="heading.logoH1" /></a>
        </h1>
    </div>

    <div class="col-lg-4 col-lg-offset-6 col-md-5 col-md-offset-5 col-sm-7 col-sm-offset-3 col-xs-12">
        <ul class="nav nav-pills navbar-right">
                <li class="dropdown" id="menu-admin">
                    <a href="#" data-toggle="dropdown" data-target="#menu-admin" class="dropdown-toggle">
                        <i class="fa fa-fw fa-wrench"></i>
                        <span class="text"><spring:message code="admin.title"/></span>
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <c:set var="teamAdminUrl" value="/agile/team" />
                        <li>
                            <a href="<c:url value="${teamAdminUrl}"/>">
                                <i class="fa fa-fw fa-sitemap"></i>
                                <span><spring:message code="admin.teams"/></span>
                            </a>
                        </li>
                        <c:set var="resourceAdminUrl" value="/agile/resource" />
                        <li>
                            <a href="<c:url value="${partnerAdminUrl}"/>">
                                <i class="fa fa-fw fa-building-o"></i>
                                <span><spring:message code="admin.resources"/></span>
                            </a>
                        </li>
                    </ul>
                </li>
        </ul>
    </div>
</div>

