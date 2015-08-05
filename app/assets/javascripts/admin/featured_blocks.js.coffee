window.VPADMIN.featured_blocks.jcrop_api = undefined

window.VPADMIN.featured_blocks.updateCropCoordinates = (c) ->
  $("#featured_block_crop_x").val(c.x)
  $("#featured_block_crop_y").val(c.y)

window.VPADMIN.featured_blocks.init = -> 
  $("#featured_block_poster").on "change", ->
    input = @

    if input.files && input.files[0]
      preview = document.getElementById('handled')
      reader = new FileReader()

      reader.onload = (e) ->
        preview.src = e.target.result

        preview.onload = ->
          $("#featured_block_modified_width").val($("img#handled").width())
          $("button#redim").removeAttr("disabled")
          $("button#crop").removeAttr("disabled")

      reader.readAsDataURL(input.files[0])

  $("button#redim").click (e) ->
    # Deshabilitamos el cropping en caso de que esté habilitado
    unless window.VPADMIN.featured_blocks.jcrop_api == undefined
      window.VPADMIN.featured_blocks.jcrop_api.destroy()  
      $("img#handled").css("height", "auto")

    image_width = $("img#handled").width()
    minimum_width = parseInt($("#featured_block_crop_width").val())

    $("#image_resizer").slider
      max: image_width
      min: minimum_width
      value: image_width
    .on "slideStop", (e) ->
      new_value = $("#image_resizer").val()
      $("img#handled").width(new_value)
      $("#featured_block_modified_width").val(new_value)

  $("button#crop").click (e) ->
    width = $("#featured_block_crop_width").val()
    height = $("#featured_block_crop_height").val()

    $("img#handled").Jcrop
      minSize: [width, height]
      maxSize: [width, height]
      onSelect: window.VPADMIN.featured_blocks.updateCropCoordinates
      onChange: window.VPADMIN.featured_blocks.updateCropCoordinates
    , ->
      window.VPADMIN.featured_blocks.jcrop_api = @
