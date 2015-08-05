class Admin::PostsController < ApplicationController
  before_filter :dashboard_authentication
  layout 'admin'

  # GET /admin/posts
  # GET /admin/posts.json
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 30).order("id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
    @post = Post.find(params[:id])
    @post.visit!
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /admin/posts/new
  # GET /admin/posts/new.json
  def new
    @post = Post.new
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /admin/posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @post = Post.new(params[:post])
    @post.creator ||= current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to [:admin, @post], notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/posts/1
  # PUT /admin/posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [:admin, @post], notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :no_content }
    end
  end

  def tags
    @tags = ActsAsTaggableOn::Tag.where("name LIKE ?", "#{params[:filter]}%").limit(15)

    respond_to do |format|
      format.json { render json: @tags.collect {|t| {:id => t.name, :name => t.name} } }
    end
  end

  def search
    if !params[:tags].blank?
      @posts = Post.tagged_with(params[:tags])
    else
      @posts = Post.search(params[:q])
    end

    respond_to do |format|
      format.json
    end
  end
end
