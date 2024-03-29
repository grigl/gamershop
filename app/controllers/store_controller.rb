class StoreController < ApplicationController
  before_filter :current_cart

  def index
    @title = "Home"
    if params[:order_by]
      order = params[:order_by]
    else
      order = Product.ordering[:default]
    end
    if !params[:order] or params[:order] == 'desc'
      order += ' DESC'
    elsif params[:order] == 'asc'
      order += ' ASC'
    end
    products = Product.order(order)
    if params[:platform]
      @title = "#{params[:platform]} games"
      products = products.platform(params[:platform])
    end
    if params[:genre]
      products = products.genre(params[:genre])
    end
    @products = products.page(params[:page]).per_page(20)
  end

  def show
    @product = Product.find_by_id(params[:id])
    @title = "#{@product.title}"
  end

end
