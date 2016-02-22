<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ tag description="<p>Adds a JavaScript and cookie based approach to session timeout management to a page. This tag relies on the
                     <code>session-timeout</code> property set in the application's <b>web.xml</b>, so it stays consistent with
                     the server. In addition to working with the existing session timeout, this tag adds a warning modal that alerts
                     users to an imminent session timeout, and gives them the option to either log out immediately, or to keep the
                     session alive via a ping/keepalive request. If neither option is chosen before the session has timed out, then
                     the user will be automatically logged out.</p>
                     <p>The cookie used for session timeout must contain the session timeout date (as a long), and must be updated
                     by the server on every authenticated request, so pages in multiple tags can keep track of the session
                     (recommendation: add a Filter to Spring Security's filter chain to add/update this cookie on each request).
                     The JavaScript managed by this tag will ensure that the cookie will expire at the same time as session timeout;
                     however, for best practice, it is recommended to also clear this cookie on explicit logout requests as well.
                     This tag is included by <code>&lt;edo:page&gt;</code> conditionally based on its attributes having been
                     configured via the <code>&lt;edo:pageConfigSessionTimeout&gt;</code> tag.</p>" %>

<%@ attribute name="logoutUrl" required="true" description="Url of logout page to navigate to when user clicks the logout button in the session timeout warning modal." %>
<%@ attribute name="keepAliveUrl" required="true" description="Url to ping that will keep the session alive." %>

<%@ attribute name="warningPeriodSeconds" required="false" description="The number of seconds before session timeout at which time a warning modal is displayed. Default: 180" %>

<%@ attribute name="timeoutUrl" required="false" description="Url of logout page to redirect to after session timeout. Default: same as <code>logoutUrl</code>." %>
<%@ attribute name="cookieName" required="false" description="Name of the cookie that is storing the session expiration date. Default: sessionExpiration" %>
<%@ attribute name="cookiePath" required="false" description="Path of the cookie that is storing the session expiration date. Default: <code>${pageContext.request.contextPath}</code>" %>

<c:url var="timeoutUrl" value="${empty timeoutUrl ? logoutUrl : timeoutUrl}" />
<c:url var="logoutUrl" value="${logoutUrl}" />
<c:url var="keepAliveUrl" value="${keepAliveUrl}" />

<c:set var="cookieName" value="${empty cookieName ? 'sessionExpiration' : cookieName}" />
<c:set var="cookiePath" value="${empty cookiePath ? pageContext.request.contextPath : cookiePath}" />

<c:set var="warningPeriodSeconds" value="${empty warningPeriodSeconds ? 180 : warningPeriodSeconds}" />
<c:set var="warningPeriod" value="${warningPeriodSeconds * 1000}" />

<sec:authorize var="isAuthenticated" access="isAuthenticated()" />

<c:if test="${isAuthenticated}">
    <div id="session_warning_modal" class="modal fade" data-backdrop="static" role="dialog" aria-labelledby="session_warning_modal_label" aria-hidden="true" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="session_warning_modal_label">
                        <spring:message code="ux.sessionTimeout.warning.title" />
                    </h4>
                </div>
                <div class="modal-body">
                    <spring:message code="ux.sessionTimeout.warning.text" arguments="${warningPeriodSeconds}" />
                </div>
                <div class="modal-footer">
                    <a id="session_logout_btn" href="${logoutUrl}" class="btn btn-default">
                        <spring:message code="ux.sessionTimeout.logout" />
                    </a>
                    <button id="session_keep_alive_btn" class="btn btn-primary" data-dismiss="modal" onclick="$.ajax('${keepAliveUrl}', { mimeType: 'text' });">
                        <spring:message code="ux.sessionTimeout.keepAlive" />
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var edo = edo || {};
        edo.constant = edo.constant || {};
        edo.constant.PAGE_LOAD_TIME = edo.constant.PAGE_LOAD_TIME || new Date();
        edo.constant.SERVER_TIME_OFFSET = edo.constant.SERVER_TIME_OFFSET || edo.constant.PAGE_LOAD_TIME - (edo.util.cookie.get("${cookieName}") - ${pageContext.session.maxInactiveInterval * 1000});

        $(document).ready(function() {
            var sessionWarningModal = $("#session_warning_modal");

            edo.sessionTimeout.initialize(${isAuthenticated}, {
                warningTimeBeforeTimeout: ${warningPeriod},
                cookie: {
                    name: "${cookieName}",
                    path: "${cookiePath}"
                },
                autorun: true,
                active: function() {
                    sessionWarningModal.modal("hide");
                },
                warning: function() {
                    sessionWarningModal.modal("show");
                },
                timeout: function() {
                    window.location.href = "${timeoutUrl}";
                }
            });
        });
    </script>
</c:if>
