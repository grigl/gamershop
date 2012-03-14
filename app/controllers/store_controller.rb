class StoreController < ApplicationController

  def index
    @title = "Home"
    products = Product
    if params[:platform]
      @title = "#{params[:platform]} games"
      products = Product.platform(params[:platform])
    end
    if params[:genre]
      products = products.genre(params[:genre])
    end
    @products = products.order('released_date').page(params[:page]).per_page(20)
  end

  def show

  end

end
