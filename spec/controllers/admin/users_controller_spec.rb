require 'spec_helper'

describe Admin::UsersController do
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
      @user = Factory.create(:user)
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
        response.should have_selector('title', content: "#{@base_title} | Menage users")
        response.should have_selector('li.active a', content: 'Menage users')
      end

    end

    describe 'new' do

      it "should have the right title" do
        get :new
        response.should have_selector('title', content: "#{@base_title} | Create new user")
      end

    end

    describe 'create' do

      before(:each) do
        @attr = Factory.attributes_for(:user)
        @invalid_attr = Factory.attributes_for(:user, email: 'bzz')
      end

      it "should create user with valid attributes" do
        lambda do
          post :create, user: @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect if user was created" do
        post :create, user: @attr
        response.should redirect_to(users_path)
      end

      it "should not create user with invalid attributes" do
        lambda do
          post :create, user: @invalid_attr
        end.should_not change(User, :count)
      end

      it "should render form again if attributes are not valid" do
        post :create, user: @invalid_attr
        response.should have_selector('h1', content: 'Create new user')
      end
    end

    describe 'edit' do

      before(:each) do
        @user = Factory.create(:user)
      end

      it "should have the right title" do
        get :edit, id: @user.id
        response.should have_selector('title', content: "#{@base_title} | Edit user")
      end

    end

    describe 'update' do

      before(:each) do
        @user = Factory.create(:user)
        @attr = Factory.attributes_for(:user)
        @invalid_attr = Factory.attributes_for(:user, email: 'bzz')
      end

      it "should update user" do
        put :update, id: @user.id, user: @attr
        @user.reload
        @user.username.should == @attr[:username]
        @user.email.should == @attr[:email]
      end

      it "should redirect if user was updated" do
        put :update, id: @user.id, user: @attr
        response.should redirect_to(users_path)
      end

      it "should render form again if attributes are not valid" do
        put :update, id: @user.id, user: @invalid_attr
        response.should have_selector('h1', content: 'Edit user')
      end

    end

    describe 'destroy' do

      before(:each) do
        @user = Factory.create(:user)
      end

      it "should destroy user" do
        lambda do
          delete :destroy, id: @user.id
        end.should change(User, :count).by(-1)
      end

      it "should redirect after deleting user" do
        delete :destroy, id: @user.id
        response.should redirect_to(users_path)
      end

      it "should have the right redirect and notice if deleting yourself" do
        delete :destroy, id: @admin.id
        response.should redirect_to(root_path)
        flash[:notice].should == 'you have sucessfully deleted yourself'
      end

    end
  end

end
