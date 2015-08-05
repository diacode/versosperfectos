module PostsHelper
  def open_graph_for_post(post)
    capture_haml do
      shared_open_graph_properties
      haml_tag :meta, property: 'og:image', content: post.illustration
    end
  end

  def posts_index_title
    title = "Noticias"

    if params[:category_id].present?
      title += " para la categoría #{@category.name}"
    end

    if params[:tag].present?
      title += " para el tag #{@tag.name}"
    end

    title
  end
end
