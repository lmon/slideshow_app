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


if(!slideshow){ var slideshow = {}; }

$(function() {

$( "#tabs" ).tabs();

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

  $('#sliderArea').ramblingSlider({
    useLargerImage: false,
    effect: 'slideInRight'
  });

    $( "#sortable-toadd" ).sortable({
       cursor: 'crosshair',
       opacity: 0.4,
       placeholder: "ui-state-highlight",
       handle: '.handle',
       receive: function(event, ui) { 
        // on drop, uncheck the check box
        ui.item.find( "input:checkbox" ).prop('checked', false);
       },
  });

  $( "#sortable, #sortable-toadd" ).sortable({
      connectWith: ".connectedSortable"
    });

  $( "#sortable, #sortable-toadd" ).disableSelection();

//});


 // $(function() {
    $( "#sortable" ).sortable({
       cursor: 'crosshair',
       opacity: 0.4,
       placeholder: "ui-state-highlight",
       handle: '.handle',
      receive: function(event, ui) { 
        // on drop, check the check box
        console.log(ui.item.find( "input:checkbox" )) //containercheck
        ui.item.find( "input:checkbox" ).prop('checked', true);
        ui.item.find( "input:checkbox" ).attr('checked', 'checked');
        
        console.log('checkbox checked')

       },
      update: function(){
        if(!$( "#sortable" ).attr( "gid" )){console.error('there was an error w gid');return;}
        
        AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

        if( AUTH_TOKEN == null ){ console.error('there was an error w Auth');return;}

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

  });

 