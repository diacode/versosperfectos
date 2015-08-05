// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-dropdown
//= require bootstrap-modal
//= require bootstrap-tab
//= require jquery.transit
//= require vendor/jquery.highlighter
//= require vendor/jquery.raty
//= require vendor/jquery.readmore
//= require vendor/featherlight
//= require mediaelement_rails
//= require sharing_buttons
//= require init
//= require home
//= require albums
//= require artists
//= require songs
//= require profiles
//= require posts

// ==================================================================================================
// Javascript namespaces
// http://viget.com/inspire/extending-paul-irishs-comprehensive-dom-ready-execution
// 
// We pick up data attributes from <body> to find what controller and action are being executed
// NOTA: las acciones 'new' se renombran a 'new_action' para evitar conflictos  con la palabra
// reservada 'new' de JavaScript.
// 
// Common JS code is in init.js
// ==================================================================================================

UTIL = {
  exec: function( controller, action ) {
    var ns = window.VPFRONT,
        action = ( action === undefined ) ? "init" : action; // If action is empty we execute 'init'
    
    if ( controller !== "" && ns[controller] && typeof ns[controller][action] == "function" ) {
      ns[controller][action]();
    }
  },

  init: function() {
    var body = document.body,
        controller = body.getAttribute( "data-controller" ),
        action = body.getAttribute( "data-action" );

    // Common app code
    UTIL.exec( "common" );
    // Current controller code
    UTIL.exec( controller );
    // Current action code
    UTIL.exec( controller, action );
  }
};

$( document ).ready( UTIL.init );