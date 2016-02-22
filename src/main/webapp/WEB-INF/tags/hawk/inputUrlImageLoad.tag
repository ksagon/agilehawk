<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="inputUrlPath" required="true" description="input textbox id for image url" %>
<%@ attribute name="parentClass" required="true" description="targetted image tag's parent div CSS class" %>
<%@ attribute name="findPathClass" required="true" description="CSS class of html tag that wraps the image" %>
<%@ attribute name="cssClass" required="true" description="CSS class for the derived image tag" %>

<script type="text/javascript">
    function updateImage_${inputUrlPath}(inputUrl) {
        var image = "<img src='" + inputUrl.val() + "' class='" + "${cssClass}" + "'>";
        inputUrl.parents(".${parentClass}").find(".${findPathClass}").html(image);
    }

    $(document).ready(function() {
        var inputUrl = $("#" + "${inputUrlPath}");
        updateImage_${inputUrlPath}(inputUrl);
        inputUrl.change(function(){
            updateImage_${inputUrlPath}($(this));
        });
    });

</script>
