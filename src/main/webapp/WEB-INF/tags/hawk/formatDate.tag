<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ attribute name="value" required="true" type="java.util.Date"%>
<fmt:formatDate value="${value}" type="date" dateStyle="SHORT"/>