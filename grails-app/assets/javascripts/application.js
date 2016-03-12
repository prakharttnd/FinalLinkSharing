// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//
//= require jquery
//= require bootstrap.min
//= require jquery.validation.min
//= require_tree .
//= require_self

if (typeof jQuery !== 'undefined') {
    (function ($) {
        $(document).ajaxStart(function () {
            $('#spinner').fadeIn();
        }).ajaxStop(function () {
            $('#spinner').fadeOut();
        });
    })(jQuery);

    jQuery.validator.addMethod("blank", function (value, element) {
        var result = false;
        var value = value.trim();
        if (value.length > 0) {
            result = true;
        }
        return result;
    }, "This should not be blank");
}



