<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<hawk:singleActionModal id="resource_modal" modalHeader="modal.edit.resource.header" buttonName="modal.edit.resource.save" buttonAction="$('#resource_fm').submit();">
    <jsp:attribute name="content">
        <hawk:formAjax id="resource_fm" modelAttribute="resource" actionUrl="/agile/team/${teamId}/resource" layout="vertical" onSuccess="successfulUpdate">
            <form:hidden path="id" />
            <div class="row">
                <div class="col-md-4"><hawk:inputText label="resource.label.name" path="name" colspan="md-12"/></div>
				<div class="col-md-4"><hawk:inputDate label="resource.label.start" path="start" colspan="md-12"/></div>
				<div class="col-md-4"><hawk:inputDate label="resource.label.end" path="end" colspan="md-12"/></div>
			</div>
            <div class="row">
                <div class="col-md-4"><hawk:inputNumber currencyCode="USD" groupingUsed="true" currencySymbol="$" maxFractionDigits="0" label="resource.label.salary" path="salary" colspan="md-12"/></div>
				<div class="col-md-4"><hawk:inputNumber label="resource.label.weeklyHours" groupingUsed="false" path="weeklyHours" colspan="md-12"/></div>
			</div>
        </hawk:formAjax>
    </jsp:attribute>
</hawk:singleActionModal>
