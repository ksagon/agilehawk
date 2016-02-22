<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ tag description="Set up the attributes for the <code>&lt;edo:pageSupportSessionTimeout&gt;</code> tag to enable
                     it within the <code>&lt;edo:page&gt;</code> tag." %>

<%@ attribute name="logoutUrl" required="true" description="Url of logout page to navigate to when user clicks the logout button in the session timeout warning modal." %>
<%@ attribute name="keepAliveUrl" required="true" description="Url to ping that will keep the session alive." %>

<%@ attribute name="warningPeriodSeconds" required="false" description="The number of seconds before session timeout at which time a warning modal is displayed. Default: 180" %>

<%@ attribute name="timeoutUrl" required="false" description="Url of logout page to redirect to after session timeout. Default: same as <code>logoutUrl</code>." %>
<%@ attribute name="cookieName" required="false" description="Name of the cookie that is storing the session expiration date. Default: sessionExpiration" %>
<%@ attribute name="cookiePath" required="false" description="Path of the cookie that is storing the session expiration date. Default: <code>${pageContext.request.contextPath}</code>}" %>

<c:if test="${empty applicationScope.pageConfig}">
    <jsp:useBean id="pageConfig" class="java.util.HashMap" scope="application" />
</c:if>
<c:if test="${empty applicationScope.pageConfig.sessionTimeout}">
    <jsp:useBean id="sessionTimeout" class="java.util.HashMap" />
    <c:set target="${sessionTimeout}" property="logoutUrl" value="${logoutUrl}" />
    <c:set target="${sessionTimeout}" property="keepAliveUrl" value="${keepAliveUrl}" />
    <c:set target="${sessionTimeout}" property="warningPeriodSeconds" value="${warningPeriodSeconds}" />
    <c:set target="${sessionTimeout}" property="timeoutUrl" value="${timeoutUrl}" />
    <c:set target="${sessionTimeout}" property="cookieName" value="${cookieName}" />
    <c:set target="${sessionTimeout}" property="cookiePath" value="${cookiePath}" />
    <c:set target="${applicationScope.pageConfig}" property="sessionTimeout" value="${sessionTimeout}" />
</c:if>
