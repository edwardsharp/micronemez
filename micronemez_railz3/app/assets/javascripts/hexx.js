/*
 * WHEE, BLEEP!
 *
 * INFO CONTAIN'R MASONRY-STYLE
 */
$(function(){
    
    var $container = $('#info-container');
    
    $container.imagesLoaded(function(){
      $container.isotope({
        itemSelector: '.box',
        masonry: {
          columnWidth: 240
        }
      });
    });
    
    /*
    $container.infinitescroll({
      navSelector  : '#page-nav',    // selector for the paged navigation 
      nextSelector : '#page-nav a',  // selector for the NEXT link (to page 2)
      itemSelector : '.box',     // selector for all items you'll retrieve
      loading: {
          finishedMsg: 'No more pages to load.',
          img: 'http://i.imgur.com/6RMhx.gif'
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
          $container.masonry( 'appended', $newElems, true ); 
        });
      }
    ); //infinitescroll
    */
});    

/*
 * INFO__AJAX
 *
 */
$(function() {

    $('.info').on('click', function(e) {
        e.preventDefault();
        if($(this).parent().hasClass('notForHover')){
            
        } else {
            $(this).parent().addClass('notForHover');
        }
        
        if ($(this).hasClass('info_selected')) {
            
        } else {
            
            $(this).addClass('info_selected');                    
            // ajax request
            $.ajax({
                async: true,
                cache: false,
                type: 'post',
                url: '/info/ajax',
                //dataType: 'html',
                beforeSend: function() {
                    console.log('Fired prior to the ajax request');
                },
                success: function(data) {
                    console.log('Fired when the request is successfull');
                    //$('.info p').toggle();
                    $('.info').append(data);
                },
                complete: function() {
                    console.log('Fired when the request is complete');
                }
            }); //endajax
            
               
        } //endif  

    }); //endonclick

}); //INFO_FAKE_JAX

/*
 * ARCHIVE MASONRY & INFINITE SCROLL'R
 *
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
          finishedMsg: '',
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
                type: 'post',
                url: '/archives/ajax',
                //dataType: 'html',
                beforeSend: function() {
                    console.log('Fired prior to the request');
                },
                success: function(data) {
                    console.log('Fired when the request is successfull');
                    $('.archive h1').toggle();
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
          finishedMsg: '',
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
                type: 'post',
                url: '/schedules/ajax',
                //dataType: 'html',
                beforeSend: function() {
                    console.log('Fired prior to the request');
                },
                success: function(data) {
                    //console.log('Fired when the request is successfull');
                    $('.schedule h1').toggle();
                    $('.schedule').append(data);
                },
                complete: function() {
                    console.log('/schedules/ajax request is complete. going to init_schedule_infinite_scroller(');
                    init_schedule_infinite_scroller();
                }
            });
        } //endif  

              


    
    });

}); //END__SCHEDULE__AJAX



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


    //$('.middle').jScrollPane();

    $('.middle').click(function() {
        $(this).addClass('no-background');
        //$("body").css("background", "#121212");
    });
    
    //$('body').click(function() {
        //$('.no-background').removeClass('.no-background');
        //$("body").css("background", "#000");
    //});

 
});

