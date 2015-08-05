class ApplicationController < ActionController::Base
  protect_from_forgery
  http_basic_authenticate_with :name => "elsama", :password => "charlot2014" if Rails.env.staging?

  before_filter :load_banners
  before_filter :render_maintenance_mode, if: :maintenance_mode?

  rescue_from ActiveRecord::RecordNotFound do
    render_404
  end 

  def render_404
    respond_to do |type|
      type.html { render :file => "#{Rails.root}/public/404", :status => 404, :layout => false }
      type.all  { render :nothing  => true, :status => "404 Not Found" }
    end
  end  

  def render_401
    respond_to do |type|
      type.html { render :file => "#{Rails.root}/public/401", :status => 401, :layout => false }
      type.all  { render :nothing  => true, :status => "401 Access denied" }
    end
  end   

  def render_503
    render file: "#{Rails.root}/public/503", status: :service_unavailable, layout: false
  end

  def dashboard_authentication
    if current_user == nil

      session[:pre_login_controller] = params[:controller]
      session[:pre_login_action] = params[:action]
      redirect_to new_user_session_path

    elsif !current_user.belongs_to_staff?
      render_401
    end
  end

  def admin_authentication
    render_401 unless current_user.admin
  end

  def after_sign_in_path_for(resource_or_scope)
    if session[:pre_login_controller] && session[:pre_login_action]
      "/#{session[:pre_login_controller]}/#{session[:pre_login_action]}"
    else
       root_path
    end
  end

  def load_banners
    horizontal_ad = Banner.find_by_name("728x90")
    rectangle_ad = Banner.find_by_name("300x250")
    @ad_horizontal_code = horizontal_ad ? horizontal_ad.code : "" 
    @ad_rectangle = rectangle_ad ? rectangle_ad.code : ""
  end

  def render_maintenance_mode
    respond_to do |type|
      type.all { render file: "#{Rails.root}/public/maintenance", status: 503, :layout => false }
    end
  end

  def maintenance_mode?
    ENV['MAINTENANCE_MODE'] == 'true'
  end
end
