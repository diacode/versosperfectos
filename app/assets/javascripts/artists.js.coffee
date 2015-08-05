# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.VPFRONT.artists.init = ->
  # TODO: Esto está pendiente de implementar. Lo que hay es solo visible. 
  #       Falta la parte de ajax.
  # $("#fav_artist").click ->
  #   $("#fav_artist").transition
  #     perspective: '100px'
  #     rotateY: '180deg'
  #     color: '#ff0000'
  #   $("#fav_counter .quantity").text '125'

  rotatePoster = ->
    visible = $(".posters .visible")
    next = visible.next()

    if next.length == 0
      next = $(".posters .poster:first-child")

    visible.removeClass("visible")
    next.addClass("visible")

  setInterval rotatePoster, 10000

  $("#biography").readmore
    moreLink: '<a href="#">Ampliar</a>'
    lessLink: '<a href="#">Ocultar</a>'

  $("#fav_artist").on 'ajax:success', (xhr, data, status) ->
    $(@).transition
      perspective: '100px'
      rotateY: '+=360deg'

    $(@).toggleClass("liked")
    
    $("#fav_counter .quantity").text(data.likes_count)