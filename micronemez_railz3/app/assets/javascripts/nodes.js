// nodes.js
$(function() {
  $("#big-search-box").bind("keyup", function() {
    $("#big-search-box").addClass("loading"); // show the spinner
    var form = $("#live-search-form"); // grab the form wrapping the search bar.
    var url = "/nodes/live_search"; // live_search action.  
    var formData = form.serialize(); // grab the data in the form  
    $.get(url, formData, function(html) { // perform an AJAX get
      $("#big-search-box").removeClass("loading"); // hide the spinner
      $("#live-search-results").html(html); // replace the "results" div with the results
    });
  });
  
  $("#node_description").autoResize({
      maxWidth: 40,
      minHeight: 20,
      extraSpace: 20
  });
  
  $("#node_tag_list").tokenInput("/node/tags", {
    addTokenAllow: true,
    makeSortable: true,
    preventDuplicates: true,
    processPrePopulate: true,
    prePopulate: $("#node_tag_list").data("pre"),
    addTokenURL: '/node/tags.json',
    tokenInputId: "#node_tag_list"
  });
  
});