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


$(function() {
  $('#sliderArea').ramblingSlider();
});

  $(function() {
    $( "#sortable" ).sortable({
      placeholder: "ui-state-highlight",
       handle: '.handle',
	  axis: 'y'

    });
    $( "#sortable" ).disableSelection();
  });

/*       dropOnEmpty: false,
       cursor: 'crosshair',
       items: 'li',
       opacity: 0.4,
       scroll: true,
       */