window.VPADMIN.albums.init = ->
  # Inicializamos el selector de artista
  $("#album_artist_id").select2
    minimumInputLength: 2
    placeholder: "Seleccione un autor"
    multiple: false
    ajax:
      url: "/admin/artists.json"
      dataType: "json"
      data: (term, page) ->
        return {
          q: term
        }
      results: (data, page) ->
        return {
          results: data
        }
    formatResult: (artist) ->
      "<div>"+artist.name+"</div>"   
    formatSelection: (artist) ->
      artist.name

    initSelection: (element, callback) ->
      previous_artist = {}

      previous_artist.id = $(element).val()
      previous_artist.name = $("#artist_name").val() 
      
      callback previous_artist
    formatNoMatches: (term) ->
      "No se produjeron resultados para la cadena #{term}"

    formatInputTooShort: (term, minLength) ->
      "Inserte #{minLength-term.length} carácteres más."

  $("#album_artist_id").on 'change', (e) ->
    $("#album_alias_id").find('option').not('[value=""]').remove()

    $.ajax
      url: Routes.aliases_admin_artist_path(e.val)
      dataType: 'json'
      type: 'get'
      success: (data) ->
        $(data).each (idx, item) ->
          opt = $("<option/>").val(item.id).text(item.name)
          $("#album_alias_id").append(opt)


  # Inicializamos el selector de sello discográfico
  $("#album_record_label_id").select2
    width: '200px'
    minimumInputLength: 2
    placeholder: "Seleccione un sello"
    multiple: false
    allowClear: true
    ajax:
      url: "/admin/record_labels.json"
      dataType: "json"
      data: (term, page) ->
        return {
          q: term
        }
      results: (data, page) ->
        return {
          results: data
        }
    formatResult: (record_label) ->
      "<div>"+record_label.name+"</div>"   
    formatSelection: (record_label) ->
      record_label.name

    initSelection: (element, callback) ->
      previous_record_label = {}

      previous_record_label.id = $(element).val()
      previous_record_label.name = $("#record_label_name").val() 
      
      callback previous_record_label

    createSearchChoice: (term, data) ->
      pos_comma = term.indexOf(",")

      term = term.substr(0, term.indexOf(",")) if pos_comma != -1

      return {
        id: term
        name: term
      }

    formatNoMatches: (term) ->
      "No se produjeron resultados para la cadena #{term}"

    formatInputTooShort: (term, minLength) ->
      "Inserte #{minLength-term.length} carácteres más."

  $("#new_song").click ->
    row = $("<tr/>", {class: 'new'})
    col_song_selection = $("<td/>", {class:'check'}).text("-")
    col_song_id = $("<td/>").text("-")
    col_track_number = $("<td/>")
    col_song_title = $("<td>/")
    col_remove = $("<td/>", {colspan : 2})

    input_track_number = $("<input />", {type:'text', class: 'input-mini', name: 'new_tracks_number[]'})
    input_song_title = $("<input />", {type:'text', class: 'input-xxlarge', name: 'new_tracks_title[]'})
    remove_button = $("<button />", {type: 'button', class: 'btn btn-small btn-remove-song'}).text("Quitar")

    col_track_number.append input_track_number
    col_song_title.append input_song_title
    col_remove.append remove_button

    row.append col_song_selection
    row.append col_song_id
    row.append col_track_number
    row.append col_song_title
    row.append col_remove

    $("table#tracklist tbody").append row
    updateTracklistStatus()

    return

  $("#existing_song").click ->
    $("#song_search").modal("show")

  $("#massive_association").on 'click', (e) ->
    if $("#tracklist .song-selection:checked").length
      $("#artist_massive_association").modal("show")

      # Load song ids
      song_ids = $("#tracklist .song-selection:checked").map (idx, el) -> $(el).val()
      $("#massive_association_form #song_ids").val(song_ids.get().join(","))
    else
      alert "Selecciona alguna canción!"

  $("#song_selection_all").on 'click', (e) ->
    $("#tracklist .song-selection").prop("checked", $(@).is(":checked"))

  $("#massive_association_form").on 'ajax:success', (data) ->
    # TODO
    $("#artist_massive_association").modal("hide")

  # Inicializamos el selector de artista
  $("#massive_association_form #artist_id").select2
    width:'250px'
    minimumInputLength: 2
    placeholder: "Seleccione un autor"
    multiple: false
    ajax:
      url: "/admin/artists.json"
      dataType: "json"
      data: (term, page) ->
        return {
          q: term
        }
      results: (data, page) ->
        return {
          results: data
        }
    formatResult: (artist) ->
      "<div>"+artist.name+"</div>"   
    formatSelection: (artist) ->
      artist.name
    formatNoMatches: (term) ->
      "No se produjeron resultados para la cadena #{term}"
    formatInputTooShort: (term, minLength) ->
      "Inserte #{minLength-term.length} carácteres más."

  $("#song_search_form").on 'submit', (event) ->
    $(".song_search_results *").remove()
    $(".song_search_results").addClass("loading")

    $.ajax "/admin/songs/search",
      data:
        title: $("#song_search .song_search_title").val()        
        artist: $("#song_search .song_search_artist").val()        
      dataType: 'json'
      type: 'get'
      error: (jqXHR, textStatus, errorThrown) ->
        $("#existing_song").popover "hide"
        bootbox.alert "AJAX Error: #{textStatus}"

      success: (data, textStatus, jqXHR) ->
        $(".song_search_results").removeClass("loading")
        showSongSearchResults(data)

    return false

  $(".song_search_results").on 'click', '.result', (event) ->
    $result = $(@)
    $("#existing_song").popover("hide")
    addExistingSong($result.attr("data-song_id"), $result.attr("data-song_title"))

  $(".btn-remove-song").on 'click', (event) ->
    $(@).parents("tr").remove()
    updateTracklistStatus()

  # Borrado de canciones
  # ====================
  $(".btn-delete-song").on 'click', (event) ->
    $row = $(@).parents("tr")
    song_id = $row.find("td.song-id").text()

    bootbox.confirm "Estás a punto de borrar definitivamente la canción de la base de datos. <strong>¿Estas seguro?</strong>", (confirmed) ->
      if confirmed == true
        $.ajax "/admin/songs/#{song_id}",
          dataType: 'json'
          type: 'DELETE'
          error: (jqXHR, textStatus, errorThrown) ->
            bootbox.alert "AJAX Error: #{textStatus}"
          success: (data, textStatus, jqXHR) ->
            $row.hide "slow", () ->
              $row.remove()

  # Borrado de tracks
  # =================
  $(".btn-unlink-song").on 'click', (event) ->    
    $row = $(@).parents("tr")
    track_id = $row.data("track-id")

    bootbox.confirm "Vas a proceder a desligar esta canción de este disco. <strong>¿Estas seguro?</strong>", (confirmed) ->
      if confirmed == true
        $.ajax "/admin/tracks/#{track_id}",
          dataType: 'json'
          type: 'DELETE'
          error: (jqXHR, textStatus, errorThrown) ->
            bootbox.alert "AJAX Error: #{textStatus}"
          success: (data, textStatus, jqXHR) ->
            $row.hide "slow", () ->
              $row.remove()

  showSongSearchResults = (data) ->
    if data.length > 0
      $(data).each (idx, elm) ->
        result = $("<div/>", { class: 'result' }).attr("data-song_id", elm.id).attr("data-song_title", elm.title)
        result.html("#{elm.artist.name} <br/> #{elm.title}")
        $(".song_search_results").append(result)
    else
      $(".song_search_results").append('<p class="no_results">La búsqueda no arrojó resultados.</p>')

  addExistingSong = (song_id, title) ->
    row = $("<tr/>", {class: 'existing'}).attr("data-track-id", "")
    col_song_selection = $("<td/>", {class:'check'})
    col_song_id = $("<td/>")
    col_track_number = $("<td/>")
    col_song_title = $("<td>/").text(title)
    col_remove = $("<td/>", {colspan : 2})

    idx = numTracksPersisted()

    input_song_selection = $("<input />", {type: 'checkbox', class: 'song-selection', name: 'song_selection[]'}).val(song_id)
    input_song_id = $("<input />", {type:'text', class: 'input-mini', name: "album[tracks_attributes][#{idx}][song_id]"}).prop("readonly", true).val(song_id)
    input_track_number = $("<input />", {type:'text', class: 'input-mini', name: "album[tracks_attributes][#{idx}][track_number]"})
    remove_button = $("<button />", {type: 'button', class: 'btn btn-small btn-remove-song'}).text("Quitar")

    col_song_selection.append input_song_selection
    col_song_id.append input_song_id
    col_track_number.append input_track_number
    col_remove.append remove_button

    row.append col_song_selection
    row.append col_song_id
    row.append col_track_number
    row.append col_song_title
    row.append col_remove

    $("table#tracklist tbody").append row
    updateTracklistStatus()

  numTracksPersisted = () ->
    return $('#tracklist tbody tr:not([data-track_id=""])').length

  updateTracklistStatus = () ->
    new_songs = $("#tracklist tbody tr.new").length
    existing_songs = $("#tracklist tbody tr.existing").length

    $("p#status_tracklist").html("Creará <strong>#{new_songs}</strong> canciones nuevas y asociará <strong>#{existing_songs}</strong> previamente existentes.")
