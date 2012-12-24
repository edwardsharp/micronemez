/*
 * WHEE, BLEEP!
 *
 * INFO CONTAIN'R MASONRY-STYLE
 */
$(function(){
    
    var $container = $('#info-container');
    
    $container.imagesLoaded(function(){
      $container.masonry({
        itemSelector: '.box',
        columnWidth: 100
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
$(function(){
    
    var $container = $('#archive-container');
    
    $container.imagesLoaded(function(){
      $container.masonry({
        itemSelector: '.box',
        columnWidth: 100
      });
    });
    
    if ($('.archive').length > 0) {
        console.log("USING ARCHIVE ELEM");
        binder_elem = $('.archive');
    } else {
        console.log("CAN NOT FIND ARCHIVE CLASS! (USING WINDOW)!");
        binder_elem = $(window);
    }
    
    
    $container.infinitescroll({
        debug: true,
      behavior: 'local',
      binder: binder_elem,  
      extraScrollPx: 20,
      navSelector  : '.pagination',    // selector for the paged navigation 
      nextSelector : 'a.next_page',  // selector for the NEXT link (to page 2)
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
    ); //end_infinitescroll
    
});    
//ARCHIVE_FAKE_JAX
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
                async: true,
                cache: false,
                type: 'post',
                url: '/archive/ajax',
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
                    console.log('Fired when the request is complete');
                }
            });
        } //endif  

              


    
    });

}); //END__ARCHIVE__AJAX

jQuery(document).ready(function($) {

    var is_touch_device = 'ontouchstart' in document.documentElement;

    if(!is_touch_device) {
        // self-desctruct...
        console.log("ADDING ZOOM TAGETZ!");
        $('.z').zoomTarget();
    } else {
        //#TODO: aplologize, i guess.
        console.log("TOUCH DEV SELF-DESCTRUCT! (SORRY)");
    }

    //$('.middle').jScrollPane();

    $('.middle').click(function() {
        $(this).addClass('no-background');
        //$("body").css("background", "#121212");
    });
    
    $('body').click(function() {
        $('.no-background').removeClass('.no-background');
        //$("body").css("background", "#000");
    });

 
});

