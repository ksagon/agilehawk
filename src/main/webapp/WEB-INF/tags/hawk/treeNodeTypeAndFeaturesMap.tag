<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ tag description="Helper tag for tree.tag that creates a nested map structure of tree node types and features. Not intended for general use." %>

<%@ attribute name="var" required="true" type="java.lang.String" rtexprvalue="false" %>
<%@ attribute name="types" required="true" type="java.lang.Enum[]" %>
<%@ variable alias="typeAndFeaturesMap" name-from-attribute="var" scope="AT_BEGIN" %>

<c:if test="${empty availableTreeNodeTypeFeatures}">
    <jsp:useBean id="availableTreeNodeTypeFeatures" class="java.util.HashMap" scope="application" />
    <c:set target="${availableTreeNodeTypeFeatures}" property="icon" value="icon" />
    <c:set target="${availableTreeNodeTypeFeatures}" property="max_children" value="maxChildren" />
    <c:set target="${availableTreeNodeTypeFeatures}" property="max_depth" value="maxDepth" />
    <c:set target="${availableTreeNodeTypeFeatures}" property="valid_children" value="validChildTypes" />
</c:if>

<jsp:useBean id="typeAndFeaturesMap" class="java.util.HashMap" />
<c:forEach items="${types}" var="type">
    <jsp:useBean id="featuresMap" class="java.util.HashMap" />
    <c:forEach items="${availableTreeNodeTypeFeatures}" var="feature">
        <c:catch var="missingFeatureException"><c:set var="dummy">${type[feature.value]}</c:set></c:catch>
        <c:if test="${empty missingFeatureException}">
            <c:set target="${featuresMap}" property="${feature.key}" value="${type[feature.value]}" />
        </c:if>
    </c:forEach>
    <c:set target="${typeAndFeaturesMap}" property="${type}" value="${featuresMap}" />
    <c:remove var="featuresMap" />
</c:forEach>
