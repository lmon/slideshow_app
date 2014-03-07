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
//= require jquery_ujs
//= require jquery.rambling.slider
//= require jquery.ui.all
//= require bootstrap
//= require turbolinks
//= require_tree .

 var AUTH_TOKEN = (AUTH_TOKEN != null ? AUTH_TOKEN : "987987987b98798798bIU&kjhhgjhgjgj7657657");
 //var gid = (gid != null ? gid : 304);

$(function() {
  $('#sliderArea').ramblingSlider();
});

  $(function() {
    $( "#sortable" ).sortable({
       cursor: 'crosshair',
       opacity: 0.4,
      placeholder: "ui-state-highlight",
       handle: '.handle',
	  axis: 'y',
    update: function(){
        if(!$( "#sortable" ).attr( "gid" )){alert('there was an error');return;}

         $.post('/galleries/'+$( "#sortable" ).attr( "gid" )+'sort', 
        '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'));
    }
    });
    $( "#sortable" ).disableSelection();
  });

/*       dropOnEmpty: false,
       cursor: 'crosshair',
       items: 'li',
       opacity: 0.4,
       scroll: true,

       update: function() {
    $ .post('/galleries/sort', 
        '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'));
    });

       */