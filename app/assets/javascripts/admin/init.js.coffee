window.VPADMIN = new Object
window.VPADMIN.common = new Object
window.VPADMIN.featured_blocks = new Object
window.VPADMIN.posts = new Object
window.VPADMIN.albums = new Object
window.VPADMIN.record_labels = new Object
window.VPADMIN.punchlines = new Object
window.VPADMIN.artists = new Object
window.VPADMIN.songs = new Object

# Common app code to be executed BEFORE document.ready 
# ----------------------------------------------------




# Common app code to be executed AFTER document.ready
# ----------------------------------------------------
window.VPADMIN.common.init = ->
  $('.datepicker').datepicker
    format: 'dd/mm/yyyy'
    language: 'es'    
    weekStart: 1
    