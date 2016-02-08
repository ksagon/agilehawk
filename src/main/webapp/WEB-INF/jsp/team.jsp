<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><spring:message code="page.team.title"/></title>
    <c:import url="/WEB-INF/jsp/site/head.jsp" />
</head>
<body>

<div id="content">
    <div id="content-header">
        <h1>Agile Team</h1>
    </div>

    <div class="container-fluid">
        <c:forEach var="resource" items="${team.resources}">
        <div class="row-fluid">
            <div class="span12">
            ${resource.name}
            </div>
        </div>
        </c:forEach>
    </div>
</div>

</body>
</html>

