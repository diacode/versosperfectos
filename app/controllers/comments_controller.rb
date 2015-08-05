class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.content = ActionController::Base.helpers.sanitize(
                        ActionController::Base.helpers.simple_format(@comment.content), :tags => %w(br p) )

    respond_to do |format|
      hash_param = @post.permalink_hash

      if @comment.save
        hash_param[:page] = @post.comment_pages
      end

      format.html { redirect_to post_extended_url(hash_param) }
    end
  end
end
