# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.VPFRONT.songs.init = ->
  $("#lyrics").highlighter selector: ".holder"
  
  $(".holder").mousedown ->
    false

  $(".btn-right").click ->
    $(".holder").hide()
    false

  $(".btn-left").click ->
    $(".holder").hide()
    false    
  
  # Inicializacion player MediaElement (Para links de YouTube de momento)
  $("audio.youtube-audio").mediaelementplayer()

  # Inicializacion player de spotify
  if $("#song_player").length
    song_id = $("#song_player").data("song-id")
    
    $.ajax
      url: "/canciones/#{song_id}/spotify_player"
      type: 'get'
      dataType: 'html'
      success: (data) ->
        $("#song_player").html(data)