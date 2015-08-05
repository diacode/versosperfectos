#encoding: utf-8

class Admin::FeaturedBlocksController < ApplicationController
  before_filter :dashboard_authentication
  layout 'admin'

  # GET /admin/featured_blocks
  # GET /admin/featured_blocks.json
  def index
    @featured_blocks = []

    for i in 0..5
      @featured_blocks[i] = FeaturedBlock.find(:first, conditions: {slot: i})
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @featured_blocks }
    end
  end

  # GET /admin/featured_blocks/new
  # GET /admin/featured_blocks/new.json
  def new
    @featured_block = FeaturedBlock.new
    @crop_dimensions = FeaturedBlock.dimensions(params[:slot].to_i)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @featured_block }
    end
  end

  # GET /admin/featured_blocks/1/edit
  def edit
    @featured_block = FeaturedBlock.find(params[:id])
    @crop_dimensions = FeaturedBlock.dimensions(params[:slot].to_i)
  end

  # POST /admin/featured_blocks
  # POST /admin/featured_blocks.json
  def create
    @featured_block = FeaturedBlock.new(params[:featured_block])

    respond_to do |format|
      if @featured_block.save
        format.html { redirect_to admin_featured_blocks_url, notice: 'El bloque destacado fue creado correctamente.' }
        format.json { render json: @featured_block, status: :created, location: @featured_block }
      else
        format.html { render action: "new" }
        format.json { render json: @featured_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/featured_blocks/1
  # PUT /admin/featured_blocks/1.json
  def update
    @featured_block = FeaturedBlock.find(params[:id])

    respond_to do |format|
      if @featured_block.update_attributes(params[:featured_block])
        format.html { redirect_to admin_featured_blocks_url, notice: 'El bloque destacado fue actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @featured_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/featured_blocks/1
  # DELETE /admin/featured_blocks/1.json
  def destroy
    @featured_block = FeaturedBlock.find(params[:id])
    @featured_block.destroy

    respond_to do |format|
      format.html { redirect_to admin_featured_blocks_url }
      format.json { head :no_content }
    end
  end
end
