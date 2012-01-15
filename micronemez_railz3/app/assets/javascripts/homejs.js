// MICRONEMEZ HOME

$(function(){
		//resizeable 
    $('#home_index').css({'height':(($(window).height()))+'px'});
    $('#middle-scrollr').css({'height':(($(window).height())-$('#makeMeScrollable').height()-$('#bottom').height())+'px'});
    $('#home_index, #bottom').css({'width':(($(window).width()))+'px'});
    
    $(window).resize(function(){
          //$('.scroll-pane').jScrollPaneRemove();
          $('#home_index').css({'height':(($(window).height()))+'px'});
          $('#middle-scrollr').css({'height':(($(window).height())-$('#makeMeScrollable').height()-$('#bottom').height())+'px'});
          $('#home_index, #bottom').css({'width':(($(window).width()))+'px'});
          //$('.scroll-pane').jScrollPane({scrollbarWidth:15, scrollbarMargin:15});
    });
    
    // FADEZ!!
/*
    
    $(".scrollingHotSpotLeftVisible").oneTime(5000, function() {
			$('.scrollingHotSpotLeftVisible').css('background','none');		
		});
		$(".scrollingHotSpotLeftVisible").mouseover(function () {
			$(".scrollingHotSpotLeftVisible").stopTime();
			$('.scrollingHotSpotLeftVisible').css('background','url(/assets/scroll/arrow_left.png)');
			$('.scrollingHotSpotLeftVisible').css('background-repeat','no-repeat');
			$('.scrollingHotSpotLeftVisible').css('background-position','center center');		
	  }); 
		$(".scrollingHotSpotLeftVisible").mouseleave(function () {
			$(this).oneTime(1000, function() {
				$('.scrollingHotSpotLeftVisible').css('background','none');
			});
	  }); 
    
    $(".scrollingHotSpotRightVisible").oneTime(5000, function() {
			$('.scrollingHotSpotRightVisible').css('background','none');		
		});
		$(".scrollingHotSpotRightVisible").mouseover(function () {
			$(".scrollingHotSpotRightVisible").stopTime();
			$('.scrollingHotSpotRightVisible').css('background','url(/assets/scroll/arrow_right.png)');	
			$('.scrollingHotSpotRightVisible').css('background-repeat','no-repeat');
			$('.scrollingHotSpotRightVisible').css('background-position','center center');	
	  }); 
		$(".scrollingHotSpotRightVisible").mouseleave(function () {
			$(this).oneTime(1000, function() {
				$('.scrollingHotSpotRightVisible').css('background','none');
			});
	  });
*/ 
	  
	  // NAV animation
	  $("#top").oneTime(6666, function() {
			//$('#nav').css('background','none');
			//$('#nav').hide("slow");		
			$('#nav').slideUp('fast', function() {
		    $('.menuspan').show("fast");
		  });
		});
		$("#top").mouseover(function () {
			$("#top").stopTime();
			$('.menuspan').hide("fast");
			$('#nav').slideDown("slow");
			
	  }); 
		$("#top").mouseleave(function () {
			$(this).oneTime(1000, function() {
				//$('#nav').hide("slow");
				$('#nav').slideUp('fast', function() {
		    	$('.menuspan').show("fast");
		  });
			});
	  }); 
	  

});


$(document).ready(function() {
	// kaltura html5 player
	//mw.setConfig( 'Kaltura.ServiceUrl' , 'http://video.micronemez.com' );
  //mw.setConfig( 'Kaltura.CdnUrl' , 'http://video.micronemez.com' );
  //mw.setConfig('Kaltura.ServiceBase', '/api_v3/index.php?service=');
  //mw.setConfig('EmbedPlayer.EnableIframeApi', false );
  //todo: set to true?
  //mw.setConfig('EmbedPlayer.UseFlashOnAndroid', false );
  //mw.setConfig('Kaltura.LoadScriptForVideoTags', true );
  //mw.setConfig('Kaltura.AllowRemoteService', false );
  //mw.setConfig('Kaltura.UseAppleAdaptive', false );
  
  //TODO: mcrnmz hover/click pop cc and donate 
  //$.pop();
  
});


jQuery(document).keyup(function(e) {
//  if (e.keyCode == 51) { alert('TO SPEAK WITH AN OPERATOR PRESS 0'); }     // 3
//  if (e.keyCode == 48) { jQuery('#audio_button').click(); }   // 0
//  if (e.keyCode == 80) { jQuery('#audio_button').click(); }   // p
//  if (e.keyCode == 83) { jQuery('#audio_button').click(); }   // s
//  if (e.keyCode == 27) { jQuery('#copzGonnaCloseItDown').click(); }//27 esc
//  if (e.keyCode == 39) { jQuery('.nav-previous > a').click(); }//right arrow
//  if (e.keyCode == 37) { jQuery('.nav-next > a').click(); }//left arrow
});

/*
jQuery('#audio_button').live('click', function(e){
	e.preventDefault();

    if (playing == false) {
        document.getElementById('player').play();
        playing = true;
        $(this).text("stop sound");

    } else {
        document.getElementById('player').pause();
        playing = false;
        $(this).text("play sound");
    }
		
		
		setTimeout("jQuery(this).toggleClass('down')",3000);


});
*/