# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.VPFRONT.albums.init = ->
  colabHoverIn = (event) ->

  colabHoverOut = (event) ->

  $(".colab").hover(colabHoverIn, colabHoverOut)

  $("#star_meter").raty
    number: 10
    starOff: '/assets/ratings/star-gray.png'
    starOn: '/assets/ratings/star-black.png'
    width: 370
    target: '#rating_selected'
    targetKeep: true
    targetType: 'number'
    click: (score, evt) ->
      $("input#score").val(score)

  $("#rating_form").on "ajax:success", (xhr, data, status) ->
    $("#rating_modal").modal('hide')

  $("#album_fav").on 'ajax:success', (xhr, data, status) ->
    $(@).transition
      perspective: '100px'
      rotateY: '+=360deg'

    $(@).toggleClass("liked")
    
    $("#album_fav span.count").text(data.likes_count)