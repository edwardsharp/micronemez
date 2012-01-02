$(document).ready(function() {
	// VIDEOZ
	$("div#makeMeScrollable").smoothDivScroll({ 	
				
			autoScroll: "onstart" , 
			autoScrollDirection: "backandforth", 
			autoScrollStep: 1, 
			autoScrollInterval: 15,	
			startAtElementId: "startAtMe", 
			visibleHotSpots: "always"	

	});
				
								
	$("div#makeMeScrollable a").colorbox({
		speed:"500",
		iframe: false,
		href:"/video/show"
	});

	// Pause autoscrolling if the user clicks one of the images
	$("div#makeMeScrollable").bind("click", function() {
		$(this).smoothDivScroll("stopAutoScroll");
		$.pop();
	});
	
	// Start autoscrolling again when the user closes
	// the colorbox overlay
	$(document).bind('cbox_closed', function(){
		$("div#makeMeScrollable").smoothDivScroll("startAutoScroll");
	});
	
	
	
	// AUDIOZ 

	$('.scroll-pane').jScrollPane({
		autoReinitialise: true,
		scrollbarWidth:15, 
		scrollbarMargin:15
	});
	
	soundManager.url = '';
 
	function setTheme(sTheme) {
	  var o = document.getElementsByTagName('ul')[0];
	  o.className = 'playlist'+(sTheme?' '+sTheme:'');
	  return false;
	}
	
});