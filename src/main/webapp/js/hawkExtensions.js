function stripNonNumericFromInput(numericString) {
    return numericString.replace(/[^\d.-]/g, '');
}

/**
 * Allows for setting up a modal to be AJAX'd in from its triggering DOM element by the use of data-* attributes.
 *
 * data-toggle="modal-ajax" - specifies that this function should be used.
 * data-target or href - specifies the URL of the request to load the modal from; href is preferred for anchor <a> tags.
 * data-params - JSON representation of parameters to pass with the AJAX request.
 * data-show, data-shown, data-hide, data-hidden - function reference for modal event callbacks
 *
 * @see {@link hawk.modal.loadAjax}
 *
 * @example
 * <a href="${ajaxUrl}" data-toggle="modal-ajax">Open the modal!</a>
 * <a href="${ajaxUrl}" data-toggle="modal-ajax" data-params="{'modalId':'my_modal','otherParam':123}">Open the modal!</a>
 * <button type="button" data-target="${ajaxUrl}" data-toggle="modal-ajax">Open the modal!</button>
 * <button type="button" data-target="${ajaxUrl}" data-toggle="modal-ajax" data-hidden="testCallback">Open the modal!</button>
 * <script>function testCallback() { alert("hello world!"); }</script>
 */
$(document).on("click.bs.modal.data-api", "[data-toggle='modal-ajax']", function (e) {
    var $this = $(this);

    var url = $this.attr("href") || $this.data("target");
    var params = $this.data("params");

    var callbacks = {};
    $.each(hawk.modal.EVENTS, function(i, callback) {
        callbacks[callback] = hawk.util.dereference($this.data(callback), "function");
    });

    if ($this.is("a")) {
        e.preventDefault();
    }

    hawk.modal.loadAjax(url, params, callbacks);
});

$(document).ready(function() {
    //TODO: Fix unicorn widget-box collapse functionality
    /* Toggles the +/- icons on any collapsible widget boxes */
    var collapsibleItems =  $('.collapsible .collapse');

    collapsibleItems.on('hide', function() {
        $(this).parents('.collapsible').first().find('.icon').html('<i class="icon-plus"></i>');
    });
    collapsibleItems.on('show', function() {
        $(this).parents('.collapsible').first().find('.icon').html('<i class="icon-minus"></i>');
    });
    collapsibleItems.on('hidden', function() {
        $(this).parents('.collapsible').first().find('.icon').html('<i class="icon-plus"></i>');
    });


    var currentUrl =  $(location).attr('pathname');
    $("#sidebar").find("li > a").each(function() {
        var url = $(this).attr("href");
        if (url === currentUrl.substring(0, url.length)) {
            $(this).parent().addClass("active");
            $(this).parents("ul").addClass("in");
            return false;
        }
    });

    $(".input-number").on('change', function() {
            $(this).val(stripNonNumericFromInput($(this).val()));
        }
    );
});
