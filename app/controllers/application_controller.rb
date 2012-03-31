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

  def build_credit_card(params)
    credit_card = ActiveMerchant::Billing::CreditCard.new(params)
  end

  def deliver_license_keys(order)
    @user = User.find_by_id(order.user_id)
    license_keys = []
    order.line_items.each do |line_item|
      line_item.quantity.times do
        license_keys << { title: line_item.product.title, license_key: SecureRandom.urlsafe_base64 }
      end
    end
    UserMailer.deliver_license_keys(@user, license_keys).deliver
  end

  def authorize
    render 'shared/_404', status: 404, layout: false unless current_user
  end

  def admin_authorize
    render 'shared/_404', status: 404, layout: false unless current_user && current_user.admin?
  end

end
