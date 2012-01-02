//= require jquery.timer

$(function(){
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



});