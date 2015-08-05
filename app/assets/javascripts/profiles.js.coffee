window.VPFRONT.profiles.show = ->
  # Paginación artistas favoritos
  $("#load_more_favorite_artists").on "ajax:success", (xhr, data, status) ->
    $("#favorite_artists").append(data)
    if $("#favorite_artists .artist").length % 8 == 0
      user_id = $("#user_profile").data("id")
      current_page = $(@).data("page")
      current_page += 1

      $(@).data("page", current_page)
      $(@).attr("href", "/perfiles/#{user_id}/liked_artists?page=#{current_page}")
    else
      $(@).hide()

  # Paginación discos favoritos
  $("#load_more_favorite_albums").on "ajax:success", (xhr, data, status) ->
    $("#favorite_albums").append(data)
    if $("#favorite_albums .album").length % 8 == 0
      user_id = $("#user_profile").data("id")
      current_page = $(@).data("page")
      current_page += 1

      $(@).data("page", current_page)
      $(@).attr("href", "/perfiles/#{user_id}/liked_albums?page=#{current_page}")
    else
      $(@).hide()

  # Paginación canciones favoritas
  $("#load_more_favorite_songs").on "ajax:success", (xhr, data, status) ->
    $("#favorite_songs").append(data)
    if $("#favorite_songs .song").length % 10 == 0
      user_id = $("#user_profile").data("id")
      current_page = $(@).data("page")
      current_page += 1

      $(@).data("page", current_page)
      $(@).attr("href", "/perfiles/#{user_id}/liked_songs?page=#{current_page}")
    else
      $(@).hide()

  # Paginación de ratings de álbums
  $("#load_more_ratings").on "ajax:success", (xhr, data, status) ->
    $("#album_ratings").append(data)
    if $("#album_ratings .album").length % 8 == 0
      user_id = $("#user_profile").data("id")
      current_page = $(@).data("page")
      current_page += 1

      $(@).data("page", current_page)
      $(@).attr("href", "/perfiles/#{user_id}/ratings?page=#{current_page}")
    else
      $(@).hide()

  # Paginación de letras enviadas
  $("#load_more_lyrics_sent").on "ajax:success", (xhr, data, status) ->
    $("ul#lyrics_sent").append(data)
    if $("#lyrics_sent .lyric-sent").length % 10 == 0
      user_id = $("#user_profile").data("id")
      current_page = $(@).data("page")
      current_page += 1

      $(@).data("page", current_page)
      $(@).attr("href", "/perfiles/#{user_id}/lyrics_sent?page=#{current_page}")
    else
      $(@).hide()