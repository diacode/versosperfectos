class Admin::TaskLogsController < ApplicationController
  before_filter :admin_authentication
  layout 'admin'

  # GET /admin/task_logs
  # GET /admin/task_logs.json
  def index
    @logs = TaskLog.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logs }
    end
  end

  # GET /admin/task_logs/1
  # GET /admin/task_logs/1.json
  def show
    @log = TaskLog.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @log }
    end
  end
end
