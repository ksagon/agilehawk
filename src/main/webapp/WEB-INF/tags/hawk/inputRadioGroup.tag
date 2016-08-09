<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="items" required="true" type="java.util.Map" %>


<%@ attribute name="label" required="false" description="Applies a label to the radio group. Uses the provided label as a message code for the i18n message bundle. If the label should not be visible, use labelClass='sr-only' to preserve accessibility." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="id" required="false" description="optional id for radio container. path will be used as default. this id will also be used to create IDs for lbl tags" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is mediaSize-span e.g. xs-12 md-6 or xs-10 sm-8 md-6 lg-4 or just lg-3." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="inputClass" required="false" description="class placed on individual radio buttons" %>
<%@ attribute name="readonly" required="false" %>

<%@ attribute name="popoverHelpTitle" required="false" description="Help popover title. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="popoverHelpMessage" required="false" description="Text appears in help popover. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>
<%@ attribute name="inlineHelpMessage" required="false" description="Text that appears under a form field. Attempts to use the provided value as a message code for the i18n message bundle, and falls back to using the value itself." %>

<c:if test="${readonly}">
    <c:set var="readonlyMessage"><spring:bind path="${path}">${items[status.actualValue]}</spring:bind></c:set>
</c:if>

<c:set var="id" value="${empty pageScope.id ? fn:replace(path, '[', '') : pageScope.id}" />
<c:set var="id" value="${fn:replace(id, ']', '')}" />

<hawk:inputBase path="${path}" id="${id}" label="${label}" labelCode="${labelCode}" required="${required}" controlGroupClass="${controlGroupClass}"
               labelClass="${labelClass}" readonly="${readonly}" readonlyMessage="${readonlyMessage}" inputOnly="${inputOnly}"
               colspan="${colspan}" popoverHelpTitle="${popoverHelpTitle}"  popoverHelpMessage="${popoverHelpMessage}" inlineHelpMessage="${inlineHelpMessage}">
    <jsp:attribute name="inputField">
        <c:if test="${!readonly}">
            <div class="radio-group">
                <c:forEach items="${items}" var="item">
                    <div>
                        <form:radiobutton id="${path}_${item.key}" path="${path}" title="${item.value}" value="${item.key}" label="${item.value}" cssClass="${inputClass}" />
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </jsp:attribute>
</hawk:inputBase>
