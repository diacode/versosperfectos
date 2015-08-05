window.VPADMIN.record_labels.init = ->
  # Inicializamos el textarea
  $("#record_label_info").redactor
    lang: "es"
    autoresize: false