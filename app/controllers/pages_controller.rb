class PagesController < ApplicationController
  before_filter :current_cart

  def how_to_buy
    @title = 'How to buy'
  end

  def about_us
    @title = 'About us'
  end
end
