<%@ include file="/WEB-INF/jsp/site/taglib.jsp"%>

<hawk:deleteActionModal id="${modalId}" objectName="${resource.name}" objectType="resource.label.object" deleteUrl="/agile/team/${team.id}/resource/${resource.id}" onDeleteEvent="teamResourceDeleted"/>
