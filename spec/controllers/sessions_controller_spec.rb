require 'spec_helper'

describe SessionsController do

  describe 'create' do

    before(:each) do
      @user = Factory.create(:active_user)
      @admin = Factory.create(:admin)
      @invalid_attr = Factory.attributes_for(:user)
    end

    it "should sign valid user in" do
      xhr :post, :create, login: @user.email, password: @user.password
      cookies[:auth_token].should == @user.auth_token
    end

    it "should redirect not admin user to root_path" do
      xhr :post, :create, login: @user.email, password: @user.password
      response.should contain("window.location = '/'")
    end

    it "should redirect admin user to users_path" do
      xhr :post, :create, login: @admin.email, password: @admin.password
      response.should contain("window.location = '/admin/users'")
    end

    it "should not sign in invalid user" do
      xhr :post, :create, login: @invalid_attr[:email], password: @invalid_attr[:password]
      cookies.should_not have_key(:auth_token)
    end

    it "should have error message given invalid attributes" do
      xhr :post, :create, login: @invalid_attr[:email], password: @invalid_attr[:password]
      flash[:alert].should == "Wrong login or password"
    end

  end

  describe 'destroy' do

     before(:each) do
      @user = Factory.create(:active_user)
      cookies[:auth_token] = @user.auth_token
    end

    it "should sign out" do
      delete :destroy, auth_token: @user.auth_token
      cookies.should_not have_key(:auth_token)
    end

    it "should redirect to root path" do
      delete :destroy, auth_token: @user.auth_token
      response.should redirect_to(root_path)
    end

  end

end
