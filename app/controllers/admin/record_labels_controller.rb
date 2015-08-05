#encoding: utf-8

class Admin::RecordLabelsController < ApplicationController
  before_filter :dashboard_authentication
  layout 'admin'

  # GET /admin/record_labels
  # GET /admin/record_labels.json
  def index
    if !params[:q]
      @record_labels = RecordLabel.order("name ASC").paginate(:page => params[:page], :per_page => 30)
    else
      @record_labels = RecordLabel.where("name LIKE ?", "%#{params[:q]}%").order("name ASC").paginate(:page => params[:page], :per_page => 30)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @record_labels }
    end
  end

  # GET /admin/record_labels/1
  # GET /admin/record_labels/1.json
  def show
    @record_label = RecordLabel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record_label }
    end
  end

  # GET /admin/record_labels/new
  # GET /admin/record_labels/new.json
  def new
    @record_label = RecordLabel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record_label }
    end
  end

  # GET /admin/record_labels/1/edit
  def edit
    @record_label = RecordLabel.find(params[:id])
  end

  # POST /admin/record_labels
  # POST /admin/record_labels.json
  def create
    @record_label = RecordLabel.new(params[:record_label])

    respond_to do |format|
      if @record_label.save
        format.html { redirect_to admin_record_labels_url, notice: 'El sello discográfico fue creado correctamente.' }
        format.json { render json: @record_label, status: :created, location: @record_label }
      else
        format.html { render action: "new" }
        format.json { render json: @record_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/record_labels/1
  # PUT /admin/record_labels/1.json
  def update
    @record_label = RecordLabel.find(params[:id])

    respond_to do |format|
      if @record_label.update_attributes(params[:record_label])
        format.html { redirect_to admin_record_labels_url, notice: 'El sello discográfico fue actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/record_labels/1
  # DELETE /admin/record_labels/1.json
  def destroy
    @record_label = RecordLabel.find(params[:id])
    @record_label.destroy

    respond_to do |format|
      format.html { redirect_to admin_record_labels_url }
      format.json { head :no_content }
    end
  end
end
