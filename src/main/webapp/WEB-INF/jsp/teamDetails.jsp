<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<hawk:singleActionModal id="team_modal" modalHeader="modal.edit.team.header" buttonName="modal.edit.team.save" buttonAction="$('#team_fm').submit();">
    <jsp:attribute name="content">
        <hawk:formAjax id="team_fm" modelAttribute="team" actionUrl="/agile/team" layout="vertical" onSuccess="successfulUpdate">
            <form:hidden path="id" />
            <div class="row">
                <div class="col-md-4"><hawk:inputText label="team.label.name" path="name" colspan="md-12"/></div>
				<div class="col-md-4"><hawk:inputDate label="team.label.start" path="start" colspan="md-12"/></div>
				<div class="col-md-4"><hawk:inputDate label="team.label.end" path="end" colspan="md-12"/></div>
			</div>
        </hawk:formAjax>
    </jsp:attribute>
</hawk:singleActionModal>
