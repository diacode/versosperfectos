# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.VPADMIN.songs.initFeaturingArtist = (el) ->
  $(el).select2
    width: '100%'
    placeholder: 'Artista'
    minimumInputLength: 3
    formatSelection: (item) -> item.name
    formatResult: (item) -> item.name
    data:
      text: 'name'
    ajax:
      url: Routes.admin_artists_path()
      dataType: 'json'
      data: (term) ->
        {q: term}
      results: (data, page) ->
        {results: data}
    initSelection: (element, callback) ->
      id = $(element).val()
      
      if id != ""
        $.ajax(
          url: Routes.admin_artist_path(id)
          dataType: 'json'
        ).done (data) ->
          callback data

window.VPADMIN.songs.init = ->
  $('#colabos tbody').on 'cocoon:after-insert', (e, insertedItem) ->
    window.VPADMIN.songs.initFeaturingArtist(insertedItem.find('.featuring-artist'))

  window.VPADMIN.songs.initFeaturingArtist('.featuring-artist')
  
  $("#song_lyrics").redactor
    linebreaks: true
  


