<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<nav role="navigation">
    <div id="sidebar-nav">
        <ul class="list-group">
            <hawk:sidebarMenu title="home.title" url="/" icon="home" />

            <hawk:sidebarMenu title="page.team.title" url="/agile/team" icon="edit" />

            <hawk:sidebarMenu title="page.resource.title" icon="briefcase" url="/agile/resource" />
        </ul>
    </div>
</nav>
