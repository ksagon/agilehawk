<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<hawk:singleActionModal id="resource_modal" modalHeader="modal.add.teamResource.header" buttonName="modal.add.teamResource.save" buttonAction="$('#team_resource_fm').submit();">
    <jsp:attribute name="content">
        <hawk:formAjax id="team_resource_fm" modelAttribute="teamResource" actionUrl="/agile/team/${teamResource.teamId}/resource" layout="vertical" onSuccess="successfulUpdate">
            <form:hidden path="teamId" />
            <div class="row">
                <div class="col-md-12"><hawk:inputSelect label="resource.label.name" path="resourceId" colspan="md-12" items="resources"/></div>
			</div>
        </hawk:formAjax>
    </jsp:attribute>
</hawk:singleActionModal>
