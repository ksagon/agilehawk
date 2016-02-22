<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="loadUrl" required="true" %>

<%@ attribute name="hideSearchBox" required="false" %>
<%@ attribute name="searchCriteria" required="false" %>
<%@ attribute name="title" required="false" description="The string or message code that will be used as the title of the grid"%>
<%@ attribute name="panelContent" required="false" %>

<%@ attribute name="adminView" required="false" %>
<%@ attribute name="gridAction" required="false" fragment="true" %>
<%@ attribute name="isCollapsible" required="false" %>

<c:set var="isCollapsible" value="${empty isCollapsible ? false : isCollapsible}" />
<c:set var="hideSearchBox" value="${empty hideSearchBox ? false : hideSearchBox}" />

<c:set var="contentClass" />
<c:if test="${adminView}">
    <c:set var="contentClass">grid-tight</c:set>
</c:if>

<c:set var="panelContent" value="${fn:trim(panelContent)}" />
<spring:message var="title" code="${title}" text="${title}" />

<sec:authorize url="${loadUrl}">
    <style>
    div.load-indicator {
        background: url("${contextRoot}/images/globalAjaxLoader.gif") no-repeat scroll 0% 50% transparent;
        width: 220px;
        height: 19px;
        padding: 6px;
    }
    </style>

    <div class="panel panel-grid <c:if test="${isCollapsible}">collapsible</c:if>">
        <div class="panel-heading clearfix" <c:if test="${isCollapsible}">data-toggle="collapse" data-target="#${id}-c"</c:if>>
            <h5><c:choose>
                <c:when test="${isCollapsible}"><a>${title}</a></c:when>
                <c:otherwise>${title}</c:otherwise>
            </c:choose></h5>
        </div>
        <div id="${id}-c" class="panel-body ${contentClass} in">
            <c:if test="${not empty gridAction or not hideSearchBox}">
                <div class="grid-toolbar">
                    <div class="grid-action-bar">
                        <jsp:invoke fragment="gridAction" />
                    </div>
                    <c:if test="${not hideSearchBox}">
                        <div class="grid-search">
                            <input id="grid_${id}_search" title="Search" type="text" class="form-control" placeholder="Search">
                            <a id="grid_${id}_search_show_all" class="form-control-clear-btn">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </c:if>
                </div>
            </c:if>
            <div id="${id}" style="overflow-x:auto;">
                <div class="load-indicator pull-center"></div>
            </div>

            <c:if test="${panelContent != ''}">
            <div class="panel-content">${panelContent}</div>
            </c:if>
        </div>
    </div>
    <script>
    var ${id}_lastGridLoadTimeoutId;
    var gridLoadTimeout = 200;
    
    $(document).ready(function() {
        $.EventBus("${id}").subscribe(load${id});
        load${id}();
        var ${id}_searchbox = $("#grid_${id}_search");
        var ${id}_searchbox_last_val = ${id}_searchbox.val();

        ${id}_searchbox.keyup(function(){
            if((${id}_searchbox.val().length >= 2 || ${id}_searchbox.val().length == 0)
                    && ${id}_searchbox_last_val !== ${id}_searchbox.val()) {
                if(typeof ${id}_lastGridLoadTimeoutId === "number"){
                    window.clearTimeout(${id}_lastGridLoadTimeoutId);
                }
                ${id}_lastGridLoadTimeoutId = window.setTimeout(load${id}, gridLoadTimeout);
                ${id}_searchbox_last_val = ${id}_searchbox.val();
            }
        });

        $("#grid_${id}_search_show_all").click(function(){
            if(typeof ${id}_lastGridLoadTimeoutId == "number"){
                window.clearTimeout(${id}_lastGridLoadTimeoutId);
            }
            ${id}_searchbox.val("");
            ${id}_searchbox_last_val = ${id}_searchbox.val();
            load${id}();
        });
    });

    function load${id}() {
        var container = $("#${id}");
        var loadUrl = "<c:url value="${loadUrl}/${id}"/>";
        var searchCriteria = null;
        var keywords = $("#grid_${id}_search").val();
        <c:if test="${not empty searchCriteria}">searchCriteria = "${searchCriteria}";</c:if>
        $.EventBus("loadGrid").publish(container, loadUrl, searchCriteria,  keywords);
    }

    </script>
</sec:authorize>

