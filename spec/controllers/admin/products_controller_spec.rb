require 'spec_helper'

describe Admin::ProductsController do
  render_views

  describe "when not signed in" do

    it "should render 404" do
      get :index
      response.should have_selector('h1', 
                      content: "The page you were looking for doesn't exist.")
    end

  end

  describe "when signed in but not admin" do

    before(:each) do
      @user = Factory.create(:active_user)
      cookies[:auth_token] = @user.auth_token
    end

    it "should render 404" do
      get :index
      response.should have_selector('h1', 
                      content: "The page you were looking for doesn't exist.")
    end

  end

  describe "when signed in and admin" do

    before(:each) do
      @base_title = 'Gamershop | Admin'

      @admin = Factory.create(:admin)
      cookies[:auth_token] = @admin.auth_token
    end

    describe 'index' do

      it "should have the right title and active link" do
        get :index
        response.should have_selector('title', content: "#{@base_title} | Menage products")
        response.should have_selector('li.active a', content: 'Menage products')
      end

    end

    describe 'new' do

      it "should have the right title" do
        get :new
        response.should have_selector('title', content: "#{@base_title} | Create new product")
      end

    end

    describe 'create' do

      before(:each) do
        @attr = Factory.attributes_for(:product)
      end

      it "should create product with valid attributes" do
        lambda do
          post :create, product: @attr
        end.should change(Product, :count).by(1)
      end

      it "should redirect if product was created" do
        post :create, product: @attr
        response.should redirect_to(products_path)
      end

      it "should not create product with invalid attributes" do
        product = Factory.create(:product)
        @invalid_attr = Factory.attributes_for(:product, title: product.title, image_url: 'fff.doc')
        lambda do
          post :create, product: @invalid_attr
        end.should_not change(Product, :count)
      end

      it "should render form again if attributes are not valid" do
        product = Factory.create(:product)
        @invalid_attr = Factory.attributes_for(:product, title: product.title, image_url: 'fff.doc')
        post :create, product: @invalid_attr
        response.should have_selector('h1', content: 'Create new product')
      end
    end

    describe 'edit' do

      before(:each) do
        @product = Factory.create(:product)
      end

      it "should have the right title" do
        get :edit, id: @product.id
        response.should have_selector('title', content: "#{@base_title} | Edit product")
      end

    end

    describe 'update' do

      before(:each) do
        @product = Factory.create(:product)
        @attr = Factory.attributes_for(:product)
        @invalid_attr = Factory.attributes_for(:product, title: @product.title, image_url: 'fff.doc')
      end

      it "should update product" do
        put :update, id: @product.id, product: @attr
        @product.reload
        @product.title.should == @attr[:title]
      end

      it "should redirect if product was updated" do
        put :update, id: @product.id, product: @attr
        response.should redirect_to(products_path)
      end

      it "should render form again if attributes are not valid" do
        put :update, id: @product.id, product: @invalid_attr
        response.should have_selector('h1', content: 'Edit product')
      end

    end

    describe 'destroy' do

      before(:each) do
        @product = Factory.create(:product)
      end

      it "should destroy product" do
        lambda do
          delete :destroy, id: @product.id
        end.should change(Product, :count).by(-1)
      end

      it "should redirect after deleting product" do
        delete :destroy, id: @product.id
        response.should redirect_to(products_path)
      end

    end
  end

end
