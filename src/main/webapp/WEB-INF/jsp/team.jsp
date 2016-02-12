<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><spring:message code="page.team.title"/></title>
    <c:import url="/WEB-INF/jsp/site/head.jsp" />
</head>

<body>
<div id="content" class="container-fluid">
    <div id="content-header" class="row">
        <h1 class="col-md-4">Agile Team</h1>
    </div>

    <form action="${contextRoot}/agile/team/load" enctype="multipart/form-data" class="form-horizontal" method="post">
    <div class="row">
        <div class="form-group col-md-12">
            <div class="col-md-3">
				<label class="control-label" for="issues">Team Issues Source</label>
                <input type="file" name="issues" id="issues" class="form-control input-sm"/>
            </div>

            <div class="col-md-3">
				<label class="control-label" for="start">Analysis Start</label>
                <div class='input-group date' id='datetimepicker1'>
                    <input type='text' class="form-control" name="start" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
		        <script type="text/javascript">
		            $(function () {
		                $('#datetimepicker1').datetimepicker();
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

    <div class="container-fluid">
        <c:forEach var="resource" items="${team.resources}">
        <div class="row">
        	<table class="table table-striped table-condensed">
                <tr>${resource.name}</tr>
            </table>
        </div>
        </c:forEach>
    </div>
</div>

</body>
</html>

