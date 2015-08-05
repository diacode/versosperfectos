class Admin::BannersController < ApplicationController
  before_filter :admin_authentication
  layout 'admin'

  # GET /admin/banners
  # GET /admin/banners.json
  def index
    @banners = Banner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @banners }
    end
  end

  # GET /admin/banners/1
  # GET /admin/banners/1.json
  def show
    @banner = Banner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @banner }
    end
  end

  # GET /admin/banners/new
  # GET /admin/banners/new.json
  def new
    @banner = Banner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @banner }
    end
  end

  # GET /admin/banners/1/edit
  def edit
    @banner = Banner.find(params[:id])
  end

  # POST /admin/banners
  # POST /admin/banners.json
  def create
    @banner = Banner.new(params[:banner])

    respond_to do |format|
      if @banner.save
        format.html { redirect_to admin_banners_url, notice: 'Banner was successfully created.' }
        format.json { render json: @banner, status: :created, location: @banner }
      else
        format.html { render action: "new" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/banners/1
  # PUT /admin/banners/1.json
  def update
    @banner = Banner.find(params[:id])

    respond_to do |format|
      if @banner.update_attributes(params[:banner])
        format.html { redirect_to admin_banners_url, notice: 'Banner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/banners/1
  # DELETE /admin/banners/1.json
  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy

    respond_to do |format|
      format.html { redirect_to admin_banners_url }
      format.json { head :no_content }
    end
  end
end
