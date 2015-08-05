//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require vendor/soundmanager2/bernicode-animator
//= require soundmanager
//= require vendor/soundmanager2/360player
//= require sharing_buttons
//= require punchlines/init

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
    var ns = window.PUNCHLINES,
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