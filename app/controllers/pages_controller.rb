class PagesController < ApplicationController
  before_filter :current_cart
  
  def index
    @title = 'Home'
  end

  def how_to_buy
    @title = 'How to buy'
  end

  def delivery
    @title = 'Delivery'
  end

  def about_us
    @title = 'About us'
  end
end
