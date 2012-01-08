$(document).ready(function() {
		
	
	// AUDIOZ 

	$('.scroll-pane').jScrollPane({
		autoReinitialise: true
	});
	
	soundManager.url = '';
 
	function setTheme(sTheme) {
	  var o = document.getElementsByTagName('ul')[0];
	  o.className = 'playlist'+(sTheme?' '+sTheme:'');
	  return false;
	}
	
});

$(document).load(function() {
	// VIDEOZ
	
	// gotta wait for all the IMGs to load...
	// recalc width of video objectz
	//calculate total width of images in set and set width of .scrollableArea 
	width=0;
	
	$(".video_thumb").each(function(index) {
    width = width + $(this).width();
	});
	
	$(".scrollableArea").css({ 'width': width  + 'px' });
	
	$("div.scrollWrapper").jScrollPane({
		autoReinitialise: true
		
	});
			
								
	$("div#makeMeScrollable a").colorbox({
		speed:"500",
		iframe: false,
		href:"/video/show"
	});


});