require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = 'Gamershop'
  end

  describe 'index' do

    it "should have the right title and active link" do
      get :index
      response.should have_selector('title', content: "#{@base_title} | Home")
      response.should have_selector('li.active a', content: 'Home')
    end

  end

  describe 'how_to_buy' do

    it "should have the right title and active link" do
      get :how_to_buy
      response.should have_selector('title', content: "#{@base_title} | How to buy")
      response.should have_selector('li.active a', content: 'How to buy')
    end

  end

  describe 'delivery' do

    it "should have the right title and active link" do
      get :delivery
      response.should have_selector('title', content: "#{@base_title} | Delivery")
      response.should have_selector('li.active a', content: 'Delivery')
    end

  end

  describe 'about_as' do

    it "should have the right title and active link" do
      get :about_us
      response.should have_selector('title', content: "#{@base_title} | About us")
      response.should have_selector('li.active a', content: 'About us')
    end

  end
end
