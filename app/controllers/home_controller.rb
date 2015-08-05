class HomeController < ApplicationController
  def index
    posts = Post.published.includes(:categories).limit(12)
    @top_block = posts.shift(6).in_groups_of(2, false).transpose
    @bottom_block = posts.shift(6).in_groups_of(3, false).transpose
    @last_lyrics = Song.includes(:artist).last_lyrics.limit(8)
    @incoming_releases = Album.includes(:artist).incoming_releases.limit(6)
    @last_reviews = Review.includes(album: [:artist]).recent.limit(3)
    @punchlines = Punchline.limit(4)
    @featured_blocks = []
    @featured_punchline = Punchline.joins(:album).online.featured.first
    for i in 0..5
      @featured_blocks[i] = FeaturedBlock.find(:first, conditions: {slot: i})
    end
  end
end
