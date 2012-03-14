class LineItemsController < ApplicationController

  def create
    cart = current_cart
    LineItem.create(product_id: params[:id], cart_id: cart.id)

    redirect_to :back
  end
end
