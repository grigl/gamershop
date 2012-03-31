class LineItemsController < ApplicationController

  def create
    cart = current_cart
    line_item = cart.line_items.find_by_product_id(params[:id])
    if line_item
      line_item.quantity +=1
      line_item.save
    else
      LineItem.create(product_id: params[:id], cart_id: cart.id)
    end

    @cart = current_cart
    render 'shared/reload_cart_form', formats: :js
  end

  def update
    line_item = LineItem.find_by_id(params[:id])
    if params[:line_item][:quantity] == '0' || params[:line_item][:quantity] == ''
      line_item.destroy
    else
      line_item.update_attributes(params[:line_item])
    end

    @cart = current_cart
    render 'shared/reload_cart_form', formats: :js
  end

end
