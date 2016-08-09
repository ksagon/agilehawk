<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<hawk:page pageTitle="page.teams.title">
	<div class="container-fluid">
	<div class="row" style="margin-bottom: 5px">
		<div class="col-md-4"><button class="btn btn-primary" data-toggle='modal-ajax' data-target="<c:url value='/agile/teamDetails' />">Add</button></div>
	</div>

	<hawk:widgetBoxExpander id="teams" titleCode="page.teams.teams">
        <div class="row">
        	<table class="table table-striped table-condensed">
        	<thead>
        		<tr>
	        		<th>Team</th>
    	    		<th>Start</th>
    	    		<th>End</th>
        		</tr>
        	</thead>
        	<tbody>
	        <c:forEach var="team" items="${teams}" varStatus="i">
                <tr>
                	<td width="30%">${team.name}</td>
                	<td width="30%">${team.start}</td>
                	<td width="30%">${team.end}</td>
                	<td width="10%">
                	  <a class="btn btn-xs btn-info" href="<c:url value='/agile/team/${team.id}' />"><i class="fa fa-eye"></i></a>
                	  <button class="btn btn-xs btn-primary" data-toggle='modal-ajax' data-target="<c:url value='/agile/teamDetails/${team.id}' />"><i class="fa fa-edit"></i></button>
                	  <button class="btn btn-xs btn-danger" data-toggle='modal-ajax' data-target="<c:url value='/agile/team/action/delete?modalId=${team.id}&id=${team.id}' />"><i class="fa fa-trash"></i></button>
                	</td>
               	</tr>
	        </c:forEach>
			</tbody>
            </table>
        </div>
	</hawk:widgetBoxExpander>
	</div>
	
	<script>
	  $.EventBus("teamDeleted").subscribe(function(event) {
		location.reload();
	  });
	  
      function successfulUpdate() {
        $('#team_modal').modal('hide');
	    location.reload();
      }
    </script>
	
</hawk:page>
