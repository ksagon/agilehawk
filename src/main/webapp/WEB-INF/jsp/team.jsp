<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<hawk:page pageTitle="page.team.title">
	<script>
	function addResource() {
		$.ajax("/agilehawk/agile/team/${team.id}/resource/" + $('#resourceId .dropdown-menu li a.selected').text(), {
			method: 'POST',
			success: function(data, status, xhr) {
				location.reload();
			}
		});
	}
	</script>

	<div class="container-fluid">
	<div class="row">
		<h1>Team ${team.name}</h1>
	</div>

	<div class="row" style="margin-bottom: 5px">
		<form action="javascript:addResource()">
		<div class="col-md-4"><hawk:selectButton items="${resources}" id="resourceId" value="value"/> 
		<input type="submit" value="Add" class="btn btn-primary"/>
		</div>
		</form>
	</div>

   	<div class="row">
   		<div class="col-md-3">
   		Team Velocity: From ${team.start} To ${team.end} -- <fmt:formatNumber value="${team.periodStoryVelocity}" maxFractionDigits="2" minFractionDigits="2" /> Stories / Wk
   		</div>
   	</div>

	<hawk:widgetBoxExpander id="resources" titleCode="page.team.resources">
        <div class="row">
        	<table class="table table-striped table-condensed">
        	<thead>
        		<tr>
	        		<th>Resource</th>
	        		<th>Start</th>
	        		<th>End</th>
    	    		<th>Story Velocity</th>
        		</tr>
        	</thead>
        	<tbody>
	        <c:forEach var="resource" items="${team.periodResources}" varStatus="i">
                <tr>
                	<td>${resource.name}</td>
                	<td>${resource.start}</td>
                	<td>${resource.end}</td>
                	<td><fmt:formatNumber value="${resource.weeklyStoryVelocity}" maxFractionDigits="2" minFractionDigits="2" /></td>
                	<td width="10%">
                	  <a class="btn btn-xs btn-info" href="<c:url value='/agile/resource/${resource.id}' />"><i class="fa fa-eye"></i></a>
                	  <button class="btn btn-xs btn-primary" data-toggle='modal-ajax' data-target="<c:url value='/agile/resourceDetails/${resource.id}?teamId=${team.id}' />"><i class="fa fa-edit"></i></button>
                	  <button class="btn btn-xs btn-danger" data-toggle='modal-ajax' data-target="<c:url value='/agile/team/${team.id}/resource/${resource.id}/action/delete?modalId=${resource.id}&id=${resource.id}' />"><i class="fa fa-trash"></i></button>
                	</td>
               	</tr>
	        </c:forEach>
			</tbody>
            </table>
        </div>

	</hawk:widgetBoxExpander>
	</div>
	
    <script>
	  $.EventBus("teamResourceDeleted").subscribe(function(event) {
		location.reload();
	  });

      function successfulUpdate() {
        $('#resource_modal').modal('hide');
	    location.reload();
      }
    </script>
	
</hawk:page>
