<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<div class="container-fluid">
	<div class="col-sm-12">
	<img src="${contextRoot}/img/agileHawk.png" alt="<spring:message code="heading.logoH1" />"/>
	</div>
</div>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="<c:url value='/'/>">AgileHawk</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <hawk:sidebarMenu title="page.teams.title" url="/agile/teams" icon="users" />
        <hawk:sidebarMenu title="page.resources.title" url="/agile/resources" icon="user" />
      </ul>

      <form class="navbar-form navbar-left" role="Load Team" action="${contextRoot}/agile/issue/load" enctype="multipart/form-data" method="post">
        <div class="form-group">
          <span class="btn btn-default btn-file">Issue File <input type="file" name="issues" id="issues" /></span>
        </div>
        <button type="submit" class="btn btn-primary">Upload</button>
      </form>

      <ul class="nav navbar-pills navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-fw fa-wrench"></i> <span class="text"><spring:message code="admin.title"/></span> <span class="caret"></span></a>
          <ul class="dropdown-menu">
			<c:set var="teamAdminUrl" value="/agile/teams" />
			<li>
				<a href="<c:url value="${teamAdminUrl}"/>"><i class="fa fa-fw fa-users"></i>
				<span><spring:message code="admin.teams"/></span>
				</a>
			</li>

			<c:set var="resourceAdminUrl" value="/agile/resources" />
			<li>
				<a href="<c:url value="${resourceAdminUrl}"/>"><i class="fa fa-fw fa-user"></i>
				<span><spring:message code="admin.resources"/></span>
				</a>
			</li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

