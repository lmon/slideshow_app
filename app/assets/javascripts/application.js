// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks 
//= require jquery_ujs
//= require jquery.rambling.slider
//= require jquery.ui.all
//= require bootstrap
//= require turbolinks
//= require_tree .


if(!slideshow){ var slideshow = {}; }

$(document).ready(function () {
  
  slideshow.loader = function(mode){
      console.log('inside load function')
      if(mode == false){
        //show
        $('#dvLoading').fadeIn(100);

      }else{
        //hide
        $('#dvLoading').fadeOut(500);
      }
  }

/************ FOR GALLERY ************/

  $('#sliderArea').ramblingSlider({
    useLargerImage: false,
    effect: 'slideInRight'
  });

/*********** FOR Image Area Tabs ********/
if($( "#tabs" ).length > 0){ $( "#tabs" ).tabs(); }

/*********** FOR Forms sortable area ********/
if($("#sortable" ).length > 0){ console.log('Got Sortable' )  }

/*********** FOR Gallery Slideshow ********/
if($('#sliderArea').length > 0){ console.log('Got Slider' )  }


});

$(document).on('page:fetch', function() {
  $(".loading-indicator").show();
});
$(document).on('page:change', function() {
  $(".loading-indicator").hide();
});


 