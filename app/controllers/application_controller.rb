class ApplicationController < ActionController::Base
  layout 'application'

  private

  def redirect_to_by_js(path)
    render js: "window.location = '#{path}'" 
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token] 
  end   
  helper_method :current_user

  def authorize
    redirect_to root_url, alert: "You don't have permissions to access this" unless current_user && current_user.admin?
  end

end
