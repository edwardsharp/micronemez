// This is a manifest file that'll be compiled into including all the files listed below.
// // Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// // be included in the compiled file accessible from http://example.com/assets/application.js
// // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// // the compiled file.
// //
//= require jquery
//= require jquery.timer
//= require jquery.colorbox-min
//= require jquery.mousewheel
//= require mwheelIntent
//= require jquery.jscrollpane
//= require jquery.waitforimages

// //= require jquery_ujs
// //= require jquery-ui-1.8.18.custom.min
// //= require rails.validations
// //= require autocomplete-rails
// //= require jquery-tokeninput
// //= require jquery-resizer


// //= require nav

$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});