class SearchesController < ApplicationController
  before_filter :current_cart

  def show
    @title = 'Search results'
    @products = Product.where('title LIKE ?', "%#{params[:search]}%" ).page(params[:page]).per_page(10)
  end
end
