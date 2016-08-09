<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<hawk:page pageTitle="page.resources.title">
	<div class="container-fluid">
	<div class="row" style="margin-bottom: 5px">
		<div class="col-md-4"><button class="btn btn-primary" data-toggle='modal-ajax' data-target="<c:url value='/agile/resourceDetails' />">Add</button></div>
	</div>

	<hawk:widgetBoxExpander id="resources" titleCode="page.resources.resources">
        <div class="row">
        	<table class="table table-striped table-condensed">
        	<thead>
        		<tr>
	        		<th>Resource</th>
    	    		<th>Start</th>
    	    		<th>End</th>
        		</tr>
        	</thead>
        	<tbody>
	        <c:forEach var="resource" items="${resources}" varStatus="i">
                <tr>
                	<td width="30%">${resource.name}</td>
                	<td width="30%">${resource.start}</td>
                	<td width="30%">${resource.end}</td>
                	<td width="10%">
                	  <a class="btn btn-xs btn-info" href="<c:url value='/agile/resource/${resource.id}' />"><i class="fa fa-eye"></i></a>
                	  <button class="btn btn-xs btn-primary" data-toggle='modal-ajax' data-target="<c:url value='/agile/resourceDetails/${resource.id}' />"><i class="fa fa-edit"></i></button>
                	  <button class="btn btn-xs btn-danger" data-toggle='modal-ajax' data-target="<c:url value='/agile/resource/action/delete?modalId=${resource.id}&id=${resource.id}' />"><i class="fa fa-trash"></i></button>
                	</td>
               	</tr>
	        </c:forEach>
			</tbody>
            </table>
        </div>
	</hawk:widgetBoxExpander>
	</div>
	
	<script>
	  $.EventBus("resourceDeleted").subscribe(function(event) {
		location.reload();
	  });
	  
      function successfulUpdate() {
        $('#resource_modal').modal('hide');
	    location.reload();
      }
    </script>
	
</hawk:page>
