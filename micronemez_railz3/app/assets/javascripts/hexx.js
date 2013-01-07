/*
 * HEXX
 * WHEE, BLEEP!
 *
 */


/*
 * INFO__AJAX
 *
 */
$(function() {

    $('.info').on('click', function(e) {
        
        
        if ($(this).hasClass('info_selected')) {
            
        } else {
            
            $(this).addClass('info_selected');                    
            // ajax request
            $.ajax({
                async: true,
                cache: false,
                type: 'get',
                url: '/info/ajax',
                //dataType: 'html',
                beforeSend: function() {
                    //console.log('zomg, before req');
                },
                success: function(data) {
                    //console.log('info ajaz succezz!');
                    //$('.info p').toggle();
                    $('.info').append(data) //.hide().fadeIn(500);
                    $('.info').next().trigger('fader');
                },
                complete: function() {
                    //console.log('info ajax done');
                }
            }); //endajax
            
               
        } //endif  

    }); //endonclick

}); //INFO_AJAX


/*
 * CURRENT_AJAX
 *
 */
$(function() {

    $('.current').on('click', function(e) {
        
        
        if ($(this).hasClass('current_selected')) {
            
        } else {
            
            $(this).addClass('current_selected');                    
            // ajax request
            $.ajax({
                async: true,
                cache: false,
                type: 'get',
                url: '/live/ajax',
                //dataType: 'html',
                beforeSend: function() {
                    //console.log('zomg, before req');
                },
                success: function(data) {
                    //console.log('info ajaz succezz!');
                    $('.current h1').hide();
                    $('.current p').hide();

                    $('.current').append(data) //.hide().fadeIn(500);
                    $('.current').next().trigger('fader');
                },
                complete: function() {
                    //console.log('info ajax done');
                }
            }); //endajax
            
               
        } //endif  

    }); //endonclick

}); //CURRENT_AJAX


/*
 * SCHEDULE MASONRY & INFINITE SCROLL'R
 *
 */
 function init_schedule_infinite_scroller(){
    
    var $container = $('#schedule-container');
    
    $container.imagesLoaded(function(){
      $container.isotope({
        itemSelector: '.box',
        masonry: {
          columnWidth: 240
        }
      });
    });
    
    if ($('.schedule').length > 0) {
        console.log("USING schedule ELEM");
        binder_elem = $('.schedule');
        //razzle dazzle TOP/BOTTOM button thing...
        /*$('.schedule').prev().click( function(){
          //console.log("PROCESSING .SCHEDULE.PREV() CLICKZ");
          $('.schedule h1').show();
          $('html, body').animate({ scrollTop: $('.schedule').offset().top }, 500);
        });

        $('.schedule').next().click( function(){
          //console.log("PROCESSING .SCHEDULE.NEXT() CLICKZ");
          $('.schedule h1').hide();
          $('html, body').animate({ scrollTop: $('.schedule').offset().top + $('.schedule').offset().height }, 500);
        });*/
    } else {
        console.log("CAN NOT FIND schedule CLASS! (USING WINDOW)!");
        binder_elem = $(window);
    }
    
     //first test to see if these selectors exists. 
    var nav_sel = $('.schedule .pagination').length ? '.schedule .pagination' : '.pagination';
    var next_sel = $('.schedule a.next_page').length ? '.schedule a.next_page' : 'a.next_page';
    console.log("nav_sel: "+nav_sel);
    
    $container.infinitescroll({
      debug: true,
      behavior: 'local',
      binder: binder_elem,  
      extraScrollPx: 30,
      navSelector  : nav_sel,    // selector for the paged navigation 
      nextSelector : next_sel,  // selector for the NEXT link (to page 2)
      itemSelector : '.box',     // selector for all items you'll retrieve
      loading: {
          finishedMsg: 'no more datez!',
          msgText: '',
          img: '/images/loader.gif'
        }
      },
      // trigger Masonry as a callback
      function( newElements ) {
        // hide new items while they are loading
        var $newElems = $( newElements ).css({ opacity: 0 });
        // ensure that images load before adding to masonry layout
        $newElems.imagesLoaded(function(){
          // show elems now they're ready
          $newElems.animate({ opacity: 1 });
          $container.isotope( 'appended', $newElems, true ); 
        });
      }
    ); //end_infinitescroll
    
}    
//SCHEDULE_AJAX
$(function() {  
    
    $('.schedule').on('click', function(e) {
        e.preventDefault();
        if( $(this).parent().hasClass('notForHover')){
            
        } else {
            $(this).parent().addClass('notForHover');
        }
        
        if ($(this).hasClass('schedule_selected')) {
            
        } else {
            
            $(this).addClass('schedule_selected');                    
            // ajax request
            $.ajax({
                context: this,
                async: true,
                cache: false,
                type: 'get',
                url: '/upcoming/ajax',
                //dataType: 'html',
                beforeSend: function() {
                    //console.log('BEFORE THE REQUEST!');
                },
                success: function(data) {
                    //console.log('egad!');
                    //$('.schedule h1').toggle();
                    $('.schedule').append(data).hide().fadeIn(500);
                },
                complete: function() {
                    //console.log('/upcoming/ajax request is complete. going to init_schedule_infinite_scroller(');
                    init_schedule_infinite_scroller();
                }
            });
        } //endif  

              


    
    });

}); //END__SCHEDULE__AJAX



/*
 * ARCHIVE MASONRY & INFINITE SCROLL'R
 * (whee, bleep.)
 */


function init_archive_infinite_scroller(){

    var $container = $('#archive-container');
    
    $container.imagesLoaded(function(){
      $container.isotope({
        itemSelector: '.box',
        layoutMode: 'masonry',
        masonry: {
          columnWidth: 240
        }
      });
    });
     
    
    if ($('.archive').length > 0) {
        console.log("USING ARCHIVE ELEM");
        binder_elem = $('.archive');
    } else {
        console.log("CAN NOT FIND ARCHIVE CLASS! (USING WINDOW)!");
        binder_elem = $(window);
       
    }

      
    //first test to see if these selectors exists. 
    var nav_sel = $('.archive .pagination').length ? '.archive .pagination' : '.pagination';
    var next_sel = $('.archive a.next_page').length ? '.archive a.next_page' : 'a.next_page';

    $container.infinitescroll({
      debug: true,
      behavior: 'local',
      binder: binder_elem,  
      extraScrollPx: 30,
      navSelector  : nav_sel,    // selector for the paged navigation 
      nextSelector : next_sel,  // selector for the NEXT link (to page 2)
      itemSelector : '.box',     // selector for all items you'll retrieve
      loading: {
          finishedMsg: 'no more nodez!',
          msgText: '',
          img: '/images/loader.gif'
        }
      },
      // trigger Masonry as a callback
      function( newElements ) {
        // hide new items while they are loading
        var $newElems = $( newElements ).css({ opacity: 0 });
        // ensure that images load before adding to masonry layout
        $newElems.imagesLoaded(function(){
          // show elems now they're ready
          $newElems.animate({ opacity: 1 });
          $container.isotope( 'appended', $newElems ); 

          
        });
      }
    ); //end_infinitescroll  
    


    
}    
//ARCHIVE_AJAX
$(function() {  
    /*$('.archive').on('click', function(e) {
      //display teaser?

    });   */ 

    $('.archive').on('click', function(e) {
        e.preventDefault();
        if( $(this).parent().hasClass('notForHover')){
            
        } else {
            $(this).parent().addClass('notForHover');
        }
        
        if ($(this).hasClass('archive_selected')) {
            
        } else {
            
            $(this).addClass('archive_selected');                    
            // ajax request
            $.ajax({
                context: this,
                async: true,
                cache: false,
                type: 'get',
                url: '/archives/ajax',
                //dataType: 'html',
                beforeSend: function() {
                    console.log('Fired prior to the request');
                },
                success: function(data) {
                    console.log('Fired when the request is successfull');
                    //$('.archive h1').toggle();
                    $('.archive').append(data);
                },
                complete: function() {
                    console.log('/archives/ajax request is complete. going to init_archive_infinite_scroller(');
                    init_archive_infinite_scroller();
                }
            });
        } //endif  

              


    
    });

}); //END__ARCHIVE__AJAX


jQuery(document).ready(function($) {

    if(!("ontouchstart" in document.documentElement)) {
        // self-desctruct...
        //console.log("ADDING ZOOM TAGETZ!");
        document.documentElement.className += " no-touch";
        //$('.z').zoomTarget();
    } else {
        //#TODO: aplologize, i guess.
        console.log("TOUCH DEV SELF-DESCTRUCT! (SORRY)");
    }


    //$('.info').trigger('click');   $('.schedule').trigger('click'); $('.archive').trigger('click');
    //$('.middle').jScrollPane();


    setTimeout(function(){  //pass it an anonymous function that calls foo
      $('.info').trigger('click');
      //$('.info').next().stop().fadeTo("slow", 0.33);
      //$('.info').next().trigger('fader');
    },10);

    /*setTimeout(function(){  //pass it an anonymous function that calls foo
      //stop fadin after a while...
      $('.info').next().trigger('fader');
      console.log("FADER STOPPP!");
    },20000);*/

    setTimeout(function(){  //pass it an anonymous function that calls foo
      $('.current').hide().fadeIn(500); //.trigger('click');
    },500);

    setTimeout(function(){  //pass it an anonymous function that calls foo
      $('.schedule').trigger('click');
    },1000);
    

    $('.middle').click(function() {
        $(this).addClass('no-background');
        //$("body").css("background", "#121212");
    });
    



    $('.info').bind('scroll', function()
    {
      if($(this).scrollTop() + 
         $(this).innerHeight()
         >= $(this)[0].scrollHeight)
      {
        //trigger fader 
        //$('.info').next().stop().fadeTo("slow", 1);
      }
    })

    //#TODO: fix this up!
    /*$("div.current").mouseenter(function() {
      $(this).stop().fadeTo("slow", 0.80);
    }).mouseleave(function() {
      $(this).stop().fadeTo("fast", 1);
    });*/
    /*$("div.bottom").mouseenter(function() {
      $(this).stop().fadeTo("slow", 0.80);
    }).mouseleave(function() {
      $(this).stop().fadeTo("fast", 1);
    });*/


    //$('body').click(function() {
        //$('.no-background').removeClass('.no-background');
        //$("body").css("background", "#000");
    //});

 
});




