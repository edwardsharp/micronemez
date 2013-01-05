// NAV animation
$(function(){
    // FADEZ!!
    $("#top").oneTime(6666, function() {
			//$('#nav').css('background','none');
			//$('#nav').hide("slow");		
			$('#nav').fadeOut('fast', function() {
		    $('.menuspan').slideDown("fast");
		  });
		});
		$("#top").mouseover(function () {
			$("#top").stopTime();
			$('.menuspan').slideUp("fast");
			$('#nav').fadeIn("slow");
			
	  }); 
		$("#top").mouseleave(function () {
			$(this).oneTime(1000, function() {
				//$('#nav').hide("slow");
				$('#nav').fadeOut('fast', function() {
		    	$('.menuspan').slideDown("fast");
		  });
			});
	  }); 
    
});