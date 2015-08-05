#encoding=utf-8
module ApplicationHelper
  def default_title
    "VersosPerfectos: Noticias sobre Hip-Hop y Rap en Español"
  end

  def default_meta_description
    "Información sobre Hip-Hop español e internacional. La base de datos más completa sobre rap en español."
  end

  def shared_open_graph_properties
    haml_tag :meta, property: 'og:site_name', content: 'VersosPerfectos'
    haml_tag :meta, property: 'og:app_id', content: '474299890330'
  end
end
