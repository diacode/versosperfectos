class Review < ActiveRecord::Base
  attr_accessible :album_id, :author_id, :content, :score_lyrics, 
    :score_production, :score_collaborations, :score_artwork, :votes

  belongs_to :album
  belongs_to :author, class_name: 'User'

  scope :recent, order("created_at DESC")

  def total_score
    scored_fields = 0.0
    score_amount = 0.0

    if score_lyrics.present?
      scored_fields += 0.3
      score_amount += score_lyrics*0.3
    end

    if score_production.present?
      scored_fields += 0.3
      score_amount += score_production*0.3
    end

    if score_collaborations.present?
      scored_fields += 0.3
      score_amount += score_collaborations*0.3
    end

    if score_artwork.present?
      scored_fields += 0.1
      score_amount += score_artwork*0.1
    end

    (score_amount/scored_fields).round(2)
  end
end
