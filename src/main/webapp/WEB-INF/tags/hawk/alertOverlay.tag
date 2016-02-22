<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ tag description="Shows an alert that pops down from the top of the browser window when an EventBus event is fired." %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="alertContent" required="true" fragment="true" %>
<%@ attribute name="showEvent" required="true" description="The name/key of the EventBus event that can be called to show this alert. (e.g. $.EventBus('showEvent').publish();)" %>

<%@ attribute name="alertType" required="false" description="Bootstrap alert type. Accepted values are: success, info, warning, danger. Default: info." %>
<%@ attribute name="autoHide" required="false" description="If true, there will be no close button, but the alert will hide after 3.5 seconds. Default: false" %>

<c:set var="content">
    <spring:escapeBody htmlEscape="false" javaScriptEscape="true">
        <jsp:invoke fragment="alertContent" />
    </spring:escapeBody>
</c:set>

<script>
    $(document).ready(function() {
        $.EventBus("${showEvent}").subscribe(function() {
            edo.alert.popdown("body", "${content}", {
                contentId: "${id}",
                alertType: "${alertType}",
                closeLabel: "<spring:message code="ux.action.close" text="Close" />",
                autoHide: ${autoHide ? 'true' : 'false'}
            });
        });
    });
</script>
