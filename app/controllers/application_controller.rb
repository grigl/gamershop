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

  def current_cart
    if cookies[:cart_id] && Cart.find_by_id(cookies[:cart_id])
      cart = Cart.find(cookies[:cart_id])
    elsif cookies[:permanent_session]
      cart = Cart.create
      cookies.permanent[:cart_id] = cart.id
    else
      cart = Cart.create
      cookies[:cart_id] = cart.id
    end
    @cart = cart
  end

  def authorize
    render 'shared/_404', status: 404, layout: false unless current_user
  end

  def admin_authorize
    render 'shared/_404', status: 404, layout: false unless current_user && current_user.admin?
  end

end
