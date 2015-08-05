# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.VPFRONT.posts.init = ->

  # Resizing iframe videos based on:
  # http://css-tricks.com/fluid-width-youtube-videos/
  # -------------------------------------------------
  # Find all YouTube videos
  $allVideos = $(".post .content iframe[src*='youtube.com'], .post .content iframe[src*='player.vimeo.com']")

  # The element that is fluid width
  $fluidEl = $(".post .content")
  $newWidth = $fluidEl.width()

  # Figure out and save aspect ratio for each video
  $allVideos.each ->    
    # and remove the hard coded width/height
    $(@).data("aspectRatio", @height / @width)
      .removeAttr("height")
      .removeAttr("width")
      .width($newWidth)
      .height($newWidth * $(@).data('aspectRatio'))




