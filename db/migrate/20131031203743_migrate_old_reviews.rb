class MigrateOldReviews < ActiveRecord::Migration
  include ActionView::Helpers::TextHelper

  def change
    old_reviews = ActiveRecord::Base.connection.select_all("SELECT * FROM disco_resena")
    sections = ['introduccion', 'letras', 'produccion', 'colaboraciones', 'diseno', 'conclusion']

    old_reviews.each do |old_review|
      review = Review.new(album_id: old_review['id_disco'], content: '')
      review.created_at = old_review['fecha']      

      # Contenido
      if old_review['tipo'] == 0
        sections.each do |section|
          if old_review[section].present?
            review.content << "<h2>#{section.humanize}</h2>"
            if old_review[section].include?("<p>")
              review.content << old_review[section]
            else
              review.content << simple_format(old_review[section])
            end
          end
        end
      else
        review.content = old_review['introduccion']
      end

      # Puntuacion
      review.score_lyrics = old_review['nota_letras']
      review.score_production = old_review['nota_produccion']
      review.score_collaborations = old_review['nota_colaboraciones']
      review.score_artwork = old_review['nota_diseno']

      # Autor
      if old_review['id_autor_resena']
        review.author_id = old_review['id_autor_resena']
      else
        u = User.find_by_old_forum_id(old_review['id_enviador'])
        review.author_id = u.id if u
      end

      review.save
    end
  end
end
