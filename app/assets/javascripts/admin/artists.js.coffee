window.VPADMIN.artists.init = ->
  # =========
  # Funciones
  # =========
  refreshTabs = () ->
    if $("#artist_group").is(':checked') 
      $("#tab_groups").hide()
      $("#tab_members").show()
    else
      $("#tab_groups").show()
      $("#tab_members").hide()

  showArtistSearchResults = (data) ->
    if data.length > 0
      $(data).each (idx, elm) ->
        result = $("<div/>", { class: 'result' }).attr("data-artist_id", elm.id).attr("data-artist_name", elm.name)
        result.html("#{elm.name}")
        $(".artist_search_results").append(result)
    else
      $(".artist_search_results").append('<p class="no_results">La búsqueda no arrojó resultados.</p>')

  addExistingArtist = (artist_id, name) ->
    if $(".tabbable ul.nav.nav-tabs li.active").attr("id") == "tab_members"
      tbl = "member"
    else
      tbl = "group"

    row = $("<tr/>").attr("data-artist_id", artist_id)
    col_artist_id = $("<td/>")
    col_artist_name = $("<td/>")
    col_remove = $("<td/>")

    input_artist_id = $("<input/>", {type: 'text', class: 'input-mini', readonly: 'readonly', name: "artist[#{tbl}_ids][]"}).val(artist_id)
    remove_button = $("<button />", {type: 'button', class: 'btn btn-small btn-danger btn-remove-artist-related'}).text("Quitar")

    col_artist_id.append input_artist_id
    col_artist_name.text name
    col_remove.append remove_button

    row.append col_artist_id
    row.append col_artist_name
    row.append col_remove

    $("table#related_#{tbl}s tbody").append row
    $("#artist_search").modal('hide')


  # ======================
  # Inicio de la ejecución
  # ======================
  $(document).on 'change', "#artist_group", (e) ->
    refreshTabs()

  $(document).on 'submit', "form", (e) ->
    if $("#artist_group").is(":checked")
      $("table#related_groups tbody tr").remove()
    else    
      $("table#related_members tbody tr").remove()

  $("#add_related_member").on 'click', ->
    $("#artist_search").modal('show')

  $("#add_related_group").on 'click', ->
    $("#artist_search").modal('show')

  $("#artist_search_form").on 'submit', (event) ->
    $(".artist_search_results *").remove()
    $(".artist_search_results").addClass("loading")

    $.ajax "/admin/artists",
      data:
        q: $(".artist_search_name").val()        
      dataType: 'json'
      type: 'get'
      error: (jqXHR, textStatus, errorThrown) ->
        $("#existing_artist").popover "hide"
        bootbox.alert "AJAX Error: #{textStatus}"

      success: (data, textStatus, jqXHR) ->
        $(".artist_search_results").removeClass("loading")
        showArtistSearchResults(data)

    return false

  $(".artist_search_results").on 'click', '.result', (event) ->
    $result = $(@)
    $("#add_related_member, #add_related_group").popover("hide")
    addExistingArtist($result.attr("data-artist_id"), $result.attr("data-artist_name"))

  $("table#related_groups, table#related_members").on 'click', ".btn-remove-artist-related", (event) ->    
    $row = $(@).parents("tr")
    $row.hide "slow", () ->
      $row.remove()

  $("#add_unreleased_song").click (event) ->
    tr = $("<tr/>")
    
    td_id = $("<td/>")
    td_title = $("<td/>")
    td_aux = $("<td/>").html("&nbsp;")

    position = $("table#unreleased tbody .song_id_input").length

    input_id = $("<input/>"
      name: "artist[unreleased_songs_attributes][#{position}][id]"
      type: "text"
      "class": "input-mini"
      readonly: "readonly"
    )

    input_title = $("<input/>",
      name: "artist[unreleased_songs_attributes][#{position}][title]"
      type: "text"
      "class": "input-xxlarge"
      placeholder: "Título de la canción"
    ) 

    td_id.append(input_id)
    td_title.append(input_title)
    tr.append(td_id, td_title, td_aux)

    $("table#unreleased tbody").append(tr)

  # Subida de imagenes a la galería del artista
  $("#gallery_uploader")
    # Inicialización del fineUploader
    .fineUploader
      request:
        endpoint: '/admin/artists/upload_picture'
        params:
          artist_id: $("#artist_id").val()
          authenticity_token: $('input[name="authenticity_token"]').val()
      debug: true 
      failedUploadTextDisplay:
        mode: 'custom'   
    .on 'complete', (event, id, fileName, responseJSON) ->
      pic = $("<img/>").attr("src", responseJSON.picture.image.square.url)
      $("#gallery").prepend(pic) 

  refreshTabs()

  return