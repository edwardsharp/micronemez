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
	  

	  

});


$(document).ready(function() {
  //TODO: nav colorbox'rz
  /*
  $("#info").on("click", function(event){
		$(this).colorbox({
			scrolling: false,
			href:"/info.html"
			
		});
	});
  */
  
});


jQuery(document).keyup(function(e) {
  if (e.keyCode == 48) { alert('TO SPEAK WITH AN OPERATOR PRESS 0'); }     // 0
//  if (e.keyCode == 51) { jQuery('#audio_button').click(); }   // 3
//  if (e.keyCode == 80) { jQuery('#audio_button').click(); }   // p
//  if (e.keyCode == 83) { jQuery('#audio_button').click(); }   // s
//  if (e.keyCode == 27) { jQuery('#copzGonnaCloseItDown').click(); }//27 esc
//  if (e.keyCode == 39) { jQuery('.nav-previous > a').click(); }//right arrow
//  if (e.keyCode == 37) { jQuery('.nav-next > a').click(); }//left arrow
});