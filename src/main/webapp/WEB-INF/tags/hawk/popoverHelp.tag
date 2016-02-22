<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" description="The DOM element id of the &lt;a&gt; link that opens the popover." %>
<%@ attribute name="title" required="true" description="The string or message code for the resource bundle message that will be the header text above the help text." %>
<%@ attribute name="message" required="true" description="The string message code for the resource bundle message that will be the help text." %>


<edo:popover message="${message}" title="${title}" id="${id}" triggerClass="fa fa-question-circle popoverHelp edo-green"
        trigger="focus hover click" />
