# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.VPFRONT.home.init = ->
  $(window).load ->
    left_col = $("#left_column").height()
    center_col = $("#center_column").height()
    right_col = $("#right_column").height()

    $("#center_column").height(Math.max(left_col, center_col, right_col))