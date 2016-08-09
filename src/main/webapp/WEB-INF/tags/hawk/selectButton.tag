<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="hawk" tagdir="/WEB-INF/tags/hawk" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="id" required="true" %>
<%@ attribute name="items" required="true" type="java.util.Map" %>

<%@ attribute name="value" required="false" description="The key (of the key/value pair in the items map) to be initially displayed." %>
<%@ attribute name="placeholder" required="false" description="Value for placeholder attribute of the input. Attempts to use the provided placeholder as a message code for the i18n message bundle, and falls back to using the placeholder itself." %>
<%@ attribute name="placeholderText" required="false" description="deprecated, use placeholder instead" %>
<%@ attribute name="containerClass" required="false" %>
<%@ attribute name="buttonClass" required="false" %>
<%@ attribute name="buttonStyle" required="false" description="Default is 'default'. Values are used for Bootstrap btn-[buttonStyle] class on button." %>
<spring:message var="placeholder" code="${placeholder}" text="${placeholder}" />
<c:if test="${empty placeholder && not empty placeholderText}">
    <spring:message var="placeholder" code="${placeholderText}" text="${placeholderText}" />
</c:if>

<c:set var="buttonStyle" value="${empty buttonStyle ? 'default' : buttonStyle}" />

<div id="${id}" class="btn-group ${containerClass}">
    <button class="btn btn-${buttonStyle} dropdown-toggle select-button ${buttonClass}" data-toggle="dropdown">
        <span class="select-button-label">
            <c:if test="${not empty placeholderText}">
            <span class="select-button-placeholder text-muted">${placeholder}</span>
            </c:if>
            <c:if test="${not empty value}">
            <span class="select-button-value hidden">${value}</span>
            </c:if>
        </span>
        <span class="caret"></span>
    </button>
    <ul class="dropdown-menu select-button-menu">
        <c:forEach var="item" items="${items}">
        <li><a href="${item.key}">${item.value}</a></li>
        </c:forEach>
    </ul>
</div>

<c:if test="${not requestScope.ignoreInnerSelectButtonScript}">
    <script type="text/javascript">
        $(document).ready(function() {
            new hawk.tag.input.SelectButton("${id}");
        });
    </script>
</c:if>
<c:remove var="ignoreInnerSelectButtonScript" scope="request" />
