// videos.js
$(function() {
  $("#big-search-box").bind("keyup", function() {
    $("#big-search-box").addClass("loading"); // show the spinner
    var form = $("#live-search-form"); // grab the form wrapping the search bar.
    var url = "/videos/live_search"; // live_search action.  
    var formData = form.serialize(); // grab the data in the form  
    $.get(url, formData, function(html) { // perform an AJAX get
      $("#big-search-box").removeClass("loading"); // hide the spinner
      $("#live-search-results").html(html); // replace the "results" div with the results
    });
  });
  
  $("#video_description").autoResize({
      maxWidth: 40,
      minHeight: 20,
      extraSpace: 20
  });
  
  $("#video_tag_list").tokenInput("/video/tags", {
    addTokenAllow: true,
    makeSortable: true,
    preventDuplicates: true,
    processPrePopulate: true,
    prePopulate: $("#video_tag_list").data("pre"),
    addTokenURL: '/video/tags.json',
    tokenInputId: "#video_tag_list"
  });
  
});