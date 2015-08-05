class PostsController < ApplicationController
  before_filter :load_common

  def index
    @posts = Post.published
    
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @posts = @posts.by_category(params[:category_id]) 
    end

    if params[:tag].present?
      @tag = ActsAsTaggableOn::Tag.find(params[:tag])
      @posts = @posts.tagged_with(@tag) if params[:tag].present?
    end

    @posts = @posts.paginate(:page => params[:page], :per_page => Post::ITEMS_PER_PAGE)
    @categories = Category.all
  end

  def show
    @post = Post.published.find_by_slug(params[:slug])
    @comments_count = @post.comments.count

		if @post.draft && (current_user == nil || (!current_user.admin? && !current_user.staff?))  
			render_404
    else
      @comments = @post.comments.paginate(:page => params[:page], :per_page => 10)
		end
	end

  def comments
  end

  def feed
    @posts = Post.published.limit(20)

    respond_to do |format|
      format.rss { render layout: false }
    end
  end

  private
    def load_common
      @week_readed_news = Post.published.order("week_read_count DESC").limit(5)
      @week_commented_news = Post.unscoped.published.current_week.order("comments_count DESC").limit(5)
    end
end
