<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%@ attribute name="path" required="true" %>
<%@ attribute name="inputField" required="true" fragment="true" %>
<%@ attribute name="selectPath" required="true" %>
<%@ attribute name="selectPlacement" required="true" description="valid values are 'prepend' (select on left) and 'append' (select on right)" %>
<%@ attribute name="selectItems" required="true" type="java.util.Map" %>

<%@ attribute name="label" required="false" description="Applies a label to the group. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<c:if test="${readonly}">
    <c:set var="key"><spring:bind path="${selectPath}">${status.value}</spring:bind></c:set>
    <c:out value="${selectItems[key]}" />
</c:if>

<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>

<c:set var="inputSelectButton">
    <edo:inputSelectButton path="${selectPath}" items="${selectItems}" inputOnly="true"
                           buttonContainerClass="input-group-btn" readonly="${readonly}" placeholder="${placeholder}" />
</c:set>

<edo:inputBase path="${path}" label="${label}" labelCode="${labelCode}" required="${required}" controlGroupClass="${controlGroupClass}" labelClass="${labelClass}"
               readonly="${readonly}" inputOnly="${inputOnly}" colspan="${colspan}">
    <jsp:attribute name="inputField">
        <div class="input-group">
            <c:if test="${selectPlacement eq 'prepend'}">
                ${inputSelectButton}
            </c:if>
            <jsp:invoke fragment="inputField" />
            <c:if test="${selectPlacement eq 'append'}">
                ${inputSelectButton}
            </c:if>
        </div>
    </jsp:attribute>
</edo:inputBase>
