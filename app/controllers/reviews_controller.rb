class ReviewsController < ApplicationController
  def show
  	@album = Album.find(params[:album_id])
  	@review = Review.find(params[:id])
  end
end
