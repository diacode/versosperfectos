window.VPADMIN.punchlines.edit = ->  
  $("#punchline_upload").fineUploader
    request:
      endpoint: Routes.upload_file_admin_punchline_path($("#punchline_id").val())
      params:
        authenticity_token: $('input[name="authenticity_token"]').val()
    debug: true 
    failedUploadTextDisplay:
      mode: 'custom'   
  .on 'complete', (event, id, fileName, responseJSON) ->
    # pic = $("<img/>").attr("src", responseJSON.picture.image.square.url)
    # $("#gallery").prepend(pic)  

  $("#artwork_upload").fineUploader
    request:
      endpoint: Routes.upload_artwork_admin_punchline_path($("#punchline_id").val())
      params:
        authenticity_token: $('input[name="authenticity_token"]').val()
    debug: true 
    failedUploadTextDisplay:
      mode: 'custom'   
  .on 'complete', (event, id, fileName, responseJSON) ->
    pic = $("<img/>").attr("src", responseJSON.artwork.art.url)
    row = $("<tr/>")
    col_pic = $("<td/>", {class: 'col-thumb'})
    col_title = $("<td/>").text(responseJSON.artwork.title)
    col_action = $("<td/>")
    btn_delete = $("<a />", {href: Routes.destroy_artwork_admin_punchline_path($("#punchline_id").val(), {artwork_id: responseJSON.artwork.id}), class: 'btn btn-danger'}).text("Borrar")
    btn_delete.attr("data-method", "delete")
    col_pic.append(pic)
    col_action.append(btn_delete)
    row.append(col_pic, col_title, col_action)

    $("#artworks tbody").append(row)   

  $("#generate_package").on 'ajax:success', (xhr, data, status) =>
    $("#generate_package").attr('disabled', 'disabled')
    $(".package-link").html("")
    @trackPackageStatus()

  $(".delete-song-file").on 'ajax:success', (xhr, data, status) ->
    row = $("#punchline_tracklist tbody tr[data-song-file-id=\"#{data.id}\"]")
    row.find('.num-downloads').text("N/D")
    row.find('.download-available').text("No")
    row.find('.delete-song-file').hide()

window.VPADMIN.punchlines.index = ->  
  $("#tbl_punchlines .btn-feature").on 'click', (e) ->
    clicked_button = $(@)
    punchline_id = clicked_button.data("punchline-id")

    $.ajax
      url: Routes.feature_admin_punchline_path({id:punchline_id})
      type: 'put'
      success: (data) ->
        $("#tbl_punchlines .btn-feature").removeClass("featured")
        clicked_button.addClass("featured")

  return

window.VPADMIN.punchlines.trackPackageStatus = ->
  window.VPADMIN.punchlines.timer = setInterval(@requestPackageStatus, 5000)

window.VPADMIN.punchlines.requestPackageStatus = ->
  $.ajax
    url: Routes.package_status_admin_punchline_path({id: $("#punchline_id").val()})
    type: 'get'
    dataType: 'json'
    success: (data) ->
      $('.package-status').text("#{data.status}: #{data.message}")

      if data.status != 'queued' and data.status != 'working'
        clearInterval(window.VPADMIN.punchlines.timer)
        $("#generate_package").attr('disabled', false)
        $('.package-link').html("<a class=\"btn\" href=\"#{data.package_url}\">Descargar</a>")
