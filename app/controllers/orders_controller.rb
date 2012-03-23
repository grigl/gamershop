class OrdersController < ApplicationController
  before_filter :authorize

  def create
    @cart = current_cart
    order = Order.new(params[:order])
    order.build_line_items(@cart)
    order.total_price = current_cart.total_price
    order.pay_status = 'unpaid'
    order.user_id = current_user.id
    
    if order.save
      current_cart.destroy
      cookies[:cart_id] = nil
      flash[:notice] = 'Your order has been saved'
      redirect_to_by_js order_path(order.id)
    else 
      render 'shared/reload_order_form', formats: :js
    end
  end

  def show
    @order = Order.find_by_id(params[:id])
  end

end
