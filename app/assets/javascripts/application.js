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

 //var gid = (gid != null ? gid : 304);
if(!slideshow){ var slideshow = {}; }

$(function() {

slideshow.loader = function(mode){
    console.log('inside load function')
    if(mode == false){
      //show
      $('#dvLoading').fadeIn();

    }else{
      //hide
      $('#dvLoading').fadeOut(1000);
    }
}

  $('#sliderArea').ramblingSlider();

    $( "#sortable-toadd" ).sortable({
       cursor: 'crosshair',
       opacity: 0.4,
       placeholder: "ui-state-highlight",
       handle: '.handle',
  });

  $( "#sortable, #sortable-toadd" ).sortable({
      connectWith: ".connectedSortable"
    });



});

  $(function() {
    $( "#sortable" ).sortable({
       cursor: 'crosshair',
       opacity: 0.4,
       placeholder: "ui-state-highlight",
       handle: '.handle',
      update: function(){
        if(!$( "#sortable" ).attr( "gid" )){alert('there was an error');return;}
        
        AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

        if( AUTH_TOKEN == null ){ alert('there was an error 2');return;}

/* works :  $.get('/galleries/'+$( "#sortable" ).attr( "gid" )+'/sort/id?', '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize')); */

        var postdata = { 
        'authenticity_token':AUTH_TOKEN          
        }   
         
       $.ajax({
          url: '/galleries/'+$( "#sortable" ).attr( "gid" )+'/sort/id?'+$(this).sortable('serialize'),
          data: postdata,
          type: 'post',  
          beforeSend: function (req){
            slideshow.loader(false);
            console.log('sorting start')
          },
          error: function (textStatus, errorThrown){
            slideshow.loader(true);
            console.log('sorting error')
          },
          complete: function (req){
            // call global loader func
            slideshow.loader(true);
            console.log('sorting complete')
          },
       }
      ); // end call
    } // end update
    });

    $( "#sortable" ).disableSelection();
  });

 