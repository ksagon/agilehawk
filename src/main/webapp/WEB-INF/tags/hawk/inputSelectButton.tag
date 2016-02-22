<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="edo" tagdir="/WEB-INF/tags/edo" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="items" required="true" type="java.util.Map" %>

<%@ attribute name="label" required="false" description="Applies a label to the select. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="labelCode" required="false" description="Deprecated. Use the 'label' attribute instead." %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="colspan" required="false" description="Overrides the default input colspan width. Format is '[mediaSize]-[span]+' e.g. 'xs-12 md-6' or 'xs-10 sm-8 md-6 lg-4' or just 'lg-3'." %>
<%@ attribute name="controlGroupClass" required="false" %>
<%@ attribute name="labelClass" required="false" %>
<%@ attribute name="buttonContainerClass" required="false" %>
<%@ attribute name="buttonClass" required="false" %>
<%@ attribute name="inputClass" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="inputOnly" required="false" description="Defaults to false. If true, then only the inputField will be output, without control-group, etc." %>

<c:set var="selectButtonContainerId" value="${path}_select_button" />
<c:set var="ignoreInnerSelectButtonScript" value="true" scope="request" />
<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>

<c:if test="${readonly}">
    <c:set var="readonlyMessage"><spring:bind path="${path}">${items[status.actualValue]}</spring:bind></c:set>
</c:if>

<edo:inputBase path="${path}" label="${label}" labelCode="${labelCode}" required="${required}" controlGroupClass="${controlGroupClass}" labelClass="${labelClass}"
               readonly="${readonly}" readonlyMessage="${readonlyMessage}" inputOnly="${inputOnly}" colspan="${colspan}">
    <jsp:attribute name="inputField">
        <edo:selectButton id="${selectButtonContainerId}" items="${items}" placeholder="${placeholder}"
                          containerClass="${buttonContainerClass}" buttonClass="${buttonClass}" />
        <form:select path="${path}" items="${items}" cssClass="sr-only select2-ignore ${inputClass}">
            <c:if test="${not empty placeholder}"><option></option></c:if>
            <form:options items="${items}"/>
        </form:select>

        <script type="text/javascript">
            $(document).ready(function() {
                new edo.tag.input.SelectButton("${path}", "${selectButtonContainerId}", "${path}");
            });
        </script>
    </jsp:attribute>
</edo:inputBase>
