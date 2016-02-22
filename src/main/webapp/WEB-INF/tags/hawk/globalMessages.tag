<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="messageHolder" required="true" type="com.edo.marketing.ui.controller.EdoMessageHolder" %>
<%@ attribute name="id" required="false" %>

<c:if test="${messageHolder.notEmpty == true}">
    <div id="${id}">
    <c:if test="${messageHolder.withErrorMessage == true}">
        <div class="alert alert-danger">
	        <ul>
	        <c:forEach items="${messageHolder.errorMessages}" var="msg">
	            <li>${msg}</li>
	        </c:forEach>  
	        </ul>
        </div>
    </c:if>
    <c:if test="${messageHolder.withInfoMessage == true}">
        <div class="alert alert-info">
            <ul>
            <c:forEach items="${messageHolder.infoMessages}" var="msg">
                <li>${msg}</li>
            </c:forEach>  
            </ul>
        </div>
    </c:if>
    </div>
</c:if>
