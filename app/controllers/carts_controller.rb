class CartsController < ApplicationController

  def destroy
    cart = Cart.find_by_id(params[:id])
    cart.line_items.each { |line_item| line_item.destroy }

    @cart = current_cart
    render 'shared/reload_cart_form', formats: :js
  end

end
