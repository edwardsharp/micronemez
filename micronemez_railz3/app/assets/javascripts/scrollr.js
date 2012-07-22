$(document).ready(function() {
		
	soundManager.url = '';
 
	function setTheme(sTheme) {
	  var o = document.getElementsByTagName('ul')[0];
	  o.className = 'playlist'+(sTheme?' '+sTheme:'');
	  return false;
	}
  
	// ALLMEDIA

	$('.home-scroll-pane').jScrollPane({
		autoReinitialise: true,
		verticalGutter: 0,
		horizontalGutter: 0,
    autoReinitialise: true,
				verticalGutter: 0,
				horizontalGutter: 0,
				showArrows: true,
				arrowScrollOnHover: true,
				horizontalArrowPositions: 'after',
				speed: 200,
				animateScroll: true,
				animateDuration: 200,
				mouseWheelSpeed: 220,
				keyboardSpeed: 200,
				scrollPagePercent: .6
	});
	

	$('div.home-scroll-pane').waitForImages(function() {
		// gotta wait for all the IMGs to load...
		// recalc width of video objectz
		//calculate total width of images in set and set width of .scrollableArea 
	  //console.log('All images have loaded.');
	  
	  width=0;
	  
		$(".video_thumb").each(function(index) {
	    width = width + $(this).width();
		});
		
		$(".scrollableArea").css({ 'width': width  + 'px' });
		
		// Using a selector:
		//$("#inline").colorbox({inline:true, href:"#myForm"});
		 
		// Using a jQuery object:
		//var $form = $("#myForm");
		//$("#inline").colorbox({inline:true, href:$form});

		//var $mcrnmz_clrbx;
    
    //TODO: yank this?
    
		$("div#bottom-scroller a").colorbox({
			scrolling: false,
			rel: 'gal', 
			title: function(){
    		var t = $(this).attr('title');
    		console.log(t);
    		return t
			},
			arrowKey: true,
			//inline:true, 
			
			href: function(){
    		var n = $(this).attr('id');
    		console.log(n);
    		return '/video/show/' + n;
			}
			
			//href:$mcrnmz_clrbx
		});

		
	
	}, function(loaded, count, success) {
	
	   //console.log(loaded + ' of ' + count + ' images has ' + (success ? 'loaded' : 'failed to load') +  '.');
	   $(this).addClass('loaded');
	
	});

	
});

