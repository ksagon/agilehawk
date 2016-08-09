<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<hawk:deleteActionModal id="${modalId}" objectName="${team.name}" objectType="team.label.object" deleteUrl="/agile/team/${team.id}" onDeleteEvent="teamDeleted"/>
