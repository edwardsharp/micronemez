$(document).ready(function() {
		
	
	// AUDIOZ 

	$('.audio-scroll-pane').jScrollPane({
		autoReinitialise: true
	});
	
	soundManager.url = '';
 
	function setTheme(sTheme) {
	  var o = document.getElementsByTagName('ul')[0];
	  o.className = 'playlist'+(sTheme?' '+sTheme:'');
	  return false;
	}
	
	// VIDEOZ
	//jScrollPane
	
	$(function()
	{
		var pane = $('.video-scroll-pane');
		pane.jScrollPane(
			{
				autoReinitialise: true
			}
		);
		var api = pane.data('jsp');
		
		//everyTime: function(interval, label, fn, times, belay)
		//$('.video-scroll-pane').everyTime(10, function() {
		//	api.scrollBy(1, 0);	
		//});

		
});



	$('div.video-scroll-pane').waitForImages(function() {
		// gotta wait for all the IMGs to load...
		// recalc width of video objectz
		//calculate total width of images in set and set width of .scrollableArea 
	  //console.log('All images have loaded.');
	  width=0;
		
		$(".video_thumb").each(function(index) {
	    width = width + $(this).width();
		});
		
		$(".scrollableArea").css({ 'width': width  + 'px' });
		
		

		$("div#makeMeScrollable a").colorbox({
			rel: 'gal', 
			title: function(){
    		var url = $(this).attr('href');
    		//return '<a href="' + url + '" target="_blank">_perma</a>';
			},
			arrowKey: true
		});

		
	
	}, function(loaded, count, success) {
	
	   //console.log(loaded + ' of ' + count + ' images has ' + (success ? 'loaded' : 'failed to load') +  '.');
	   $(this).addClass('loaded');
	
	});

	
});

