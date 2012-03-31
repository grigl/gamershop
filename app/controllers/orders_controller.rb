class OrdersController < ApplicationController
  before_filter :authorize, except: [:new]

  def new
    @cart = current_cart
    render 'shared/reload_order_form', formats: :js
  end

  def create
    @cart = current_cart
    order = Order.new(pay_status: 'unpaid', user_id: current_user.id)
    order.build_line_items(@cart)
    order.calculate_total_price

    if order.save
      current_cart.destroy
      cookies[:cart_id] = nil
      redirect_to_by_js order_path(order.id)
    else 
      render 'shared/reload_order_form', formats: :js
    end
  end

  def show
    @title = "Profile | Orders"
    @order = Order.find_by_id(params[:id])
  end

  def purchase
    @order = Order.find_by_id(params[:id])
    credit_card = build_credit_card(params[:order][:credit_card])
    ip = request.remote_ip

    if credit_card.valid?
      response = @order.purchase(credit_card, ip)
      if response.success?
        @order.update_attribute(:pay_status, 'paid')
        deliver_license_keys(@order)
        redirect_to root_path, notice: "purchase complete! Your keys was sent to your email!"
      else
        flash.now[:alert] = "Error: #{response.message}"
        render :show 
      end
    else
      credit_card.errors.each do |field, error|
        @order.errors.add ('credit card: ' + field).to_sym, error[0] 
      end
      @title = "Profile | Orders"
      render :show 
    end
  end

end
