<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="modalTarget" required="true" %>
<%@ attribute name="width" required="true" %>
<%@ attribute name="height" required="true" %>

<%@ attribute name="altText" required="false" %>

<c:set var="imageLinkId" value="${path}_img_link" />
<c:set var="imageId" value="${path}_img" />
<c:set var="inputId" value="${path}_input" />
<c:set var="resizerDivId" value="${modalTarget}_resizer" />
<c:set var="saveImgFunction" value="${modalTarget}Save" />
<c:set var="initImgFunction" value="${path}Init" />

<form:hidden id="${inputId}" path="${path}"/>
<a id="${imageLinkId}"
   data-target="#${modalTarget}"
   data-toggle="modal"
   class="image-preview img-thumbnail"
   style="width:${width}px; height:${height}px;"
   alt="${altText}">
</a>


<script type="text/javascript">
    var ${path}CallbackUrl;

    $(document).ready(function() {
        ${initImgFunction}();
        
        $("#${modalTarget}").on("show.bs.modal", function() {
            $("#${resizerDivId}").qresizer({
                noimage: "<c:url value="/components/resizer/Styles/qresizer/noimage.png"/>",
                initimage: ${path}CallbackUrl,
                protocol: "https://",
                domain: "s3.amazonaws.com",
                awsBucket: "${configProperties.bucket}",
                options: ["size", "crop", "format"],
                size: { height:${height}, width:${width}},
                load: function (data) {
                    ${path}CallbackUrl = data;
                },
                error: function (eventData) {}
            });
        });
    });

    function ${initImgFunction}() {
        ${path}CallbackUrl = $("#${inputId}").val();
        if (${path}CallbackUrl) {
            $('#${imageLinkId}').html('<img id="${imageId}" src="'+${path}CallbackUrl+'" alt="${altText}"></img>');
        } else {
            $('#${imageLinkId}').html('<span style="margin-top:${height / 2 - 24}px">click to upload<br/>${width}&times;${height}</span>');
        }
    }

    function ${saveImgFunction}() {
        $('#${inputId}').val(${path}CallbackUrl);
        $('#${imageLinkId}').html('<img id="${imageId}" src="'+${path}CallbackUrl+'" alt="${altText}"></img>');
    }
</script>