//= require jquery
//= require jquery_ujs
//= require js-routes
//= require bootstrap
//= require redactor-rails
//= require fineuploader.jquery
//= require vendor/bootbox
//= require select2
//= require bootstrap-datepicker
//= require vendor/bootstrap-slider
//= require jcrop
//= require cocoon
//= require admin/init
//= require admin/artists
//= require admin/featured_blocks
//= require admin/posts
//= require admin/albums
//= require admin/record_labels
//= require admin/songs
//= require admin/punchlines

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
    var ns = window.VPADMIN,
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