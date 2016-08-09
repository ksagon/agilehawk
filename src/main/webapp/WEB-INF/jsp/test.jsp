<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<hawk:page pageTitle="page.team.title">
<div class="container-fluid">

<div class="row">
<div class="col-md-4"><button class="btn btn-primary" data-toggle="modal-ajax" data-target="<c:url value='/agile/teamDetails' />">Mode It</button></div>
</div>


<!-- div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Confirmation</h4>
            </div>
            <div class="modal-body">
                <p>Do you want to save changes you made to document before closing?</p>
                <p class="text-warning"><small>If you don't save, your changes will be lost.</small></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
    
    
    <hawk:singleActionModal buttonName="foobar" modalHeader="baz" buttonAction="butt" content="TEST TEST" id="hmm"></hawk:singleActionModal>
    
    
</div-->
</div>
</hawk:page>
