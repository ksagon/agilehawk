<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<hawk:page pageTitle="page.team.title">
	<hawk:widgetBoxExpander id="teamLoader" titleCode="page.team.load">
    <form action="${contextRoot}/agile/team/load" enctype="multipart/form-data" class="form-horizontal" method="post">
    <div class="row">
        <div class="form-group col-md-12">
            <div class="col-md-3">
				<label class="control-label" for="issues"><spring:message code="page.team.label.issueSource"/></label>
                <input type="file" name="issues" id="issues" class="form-control input-sm"/>
            </div>

            <div class="col-md-3">
				<label class="control-label" for="start"><spring:message code="page.team.label.analysisStart"/></label>
                <div class='input-group date' id='analysisStart-datepicker'>
                    <input type='text' class="form-control" name="start" id="start" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
		        <script type="text/javascript">
		            $(function () {
		                $('#analysisStart-datepicker').datepicker( {format: 'yyyy-mm-dd'} );
		            });
		        </script>
            </div>

            <div class="col-md-3">
				<label class="control-label" for="start"><spring:message code="page.team.label.analysisEnd"/></label>
                <div class='input-group date' id='analysisEnd-datepicker'>
                    <input type='text' class="form-control" name="end" id="end" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
		        <script type="text/javascript">
		            $(function () {
		                $('#analysisEnd-datepicker').datepicker( {format: 'yyyy-mm-dd'} );
		            });
		        </script>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="form-actions floatRight col-md-3">
            <input type="submit" value="Upload" class="btn btn-primary btn-sm">
        </div>
    </div>
    </form>
	</hawk:widgetBoxExpander>

	<hawk:widgetBoxExpander id="resources" titleCode="page.team.resources">
    <div class="container-fluid">
        <c:forEach var="resource" items="${team.resources}" varStatus="i">

    	<c:if test="${i.index == 0}">
    	<div class="row">
    		<h2>Team Velocity: From ${team.start} To ${team.end} -- <fmt:formatNumber value="${team.periodStoryVelocity}" maxFractionDigits="2" minFractionDigits="2" /> Stories / Wk</h2>
    	</div>
		</c:if>

        <div class="row">
        	<table class="table table-striped table-condensed">
                <tr>${resource.name}</tr>
            </table>
        </div>
        </c:forEach>
    </div>
	</hawk:widgetBoxExpander>
</hawk:page>
