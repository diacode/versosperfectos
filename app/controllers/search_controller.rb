class SearchController < ApplicationController
  def posts
    @results = Post.search(params[:q], 
                      where: {draft: false},
                      order: {published_at: :desc},
                      fields: [:title, :content], 
                      highlight: {tag: '<strong>'}, 
                      page: params[:page], per_page: 15)
  end
end