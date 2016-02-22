<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="id" required="true" %>

<%@ attribute name="imageName" required="false" %>

<c:set var="resizerFormId" value="${id}_form" />
<c:set var="resizerDivId" value="${id}_resizer" />
<c:set var="saveImgFunction" value="${id}Save" />

<div id="${id}" aria-hidden="true" style="display: none;" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">&times;</button>
                <h3>Upload ${empty imageName ? "Image" : imageName}</h3>
            </div>
            <div class="modal-body">
                <form id="${resizerFormId}" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="key" />
                    <input type="hidden" name="AWSAccessKeyId" value="${configProperties.accessKey}" />
                    <input type="hidden" name="acl" value="public-read" />
                    <input type="hidden" name="policy" />
                    <input type="hidden" name="signature" />
                    <input type="hidden" name="success_action_status" value="201" />
                    <div id="${resizerDivId}" style="width: 500px; height: 350px;"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-link" aria-hidden="true" data-dismiss="modal">
                    Cancel
                </button>
                <button class="btn btn-success" data-dismiss="modal" onclick="${saveImgFunction}()">
                    Save Image
                </button>
            </div>
        </div>
    </div>
</div>