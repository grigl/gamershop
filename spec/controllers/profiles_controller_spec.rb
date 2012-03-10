require 'spec_helper'

describe ProfilesController do
  render_views

  describe "create" do

    before(:each) do
      @attr = Factory.attributes_for(:user)
      @invalid_attr = Factory.attributes_for(:user, email: 'foo')
    end

    it "should create user if attributes are valid" do
      lambda do
        xhr :post, :create, user: @attr
      end.should change(User, :count).by(1)
    end

    it "should not create active user" do
      xhr :post, :create, user: @attr
      user = User.find_by_email(@attr[:email])
      user.active.should_not be_true
    end

    it "should generate activation token for new user" do
      xhr :post, :create, user: @attr
      User.find_by_email(@attr[:email]).auth_token.should_not be_nil
    end

    it "should redirect to root after creating user" do
      xhr :post, :create, user: @attr
      response.should contain("window.location = '/'")
    end

    it "should email created user with registration confirmation" do
      xhr :post, :create, user: @attr
      ActionMailer::Base.deliveries.last.to.should include(@attr[:email])
    end

    it "should not create user if attributes are invalid" do
      lambda do
        xhr :post, :create, user: @invalid_attr
      end.should_not change(User, :count)
    end

    it "should should rerender the form if attributes are invaid" do
      xhr :post, :create, user: @invalid_attr
      response.should contain('Email is invalid') 
    end

  end

  describe "activate" do

    it "should activate user with right activation_token given" do
      user = Factory.create(:user)
      post :activate, activation_token: user.activation_token
      user.reload
      user.active.should be_true
    end

    it "should render 404 if user doesn't exist with given activation_token" do
      post :activate, activation_token: 'wrong'
      response.should contain("The page you were looking for doesn't exist.")
    end

  end

  describe "password_reset" do

    it "should create new password" do
      user = Factory.create(:user)
      xhr :post, :password_reset, email: user.email
      updated_user = User.find(user.id)
      updated_user.password_digest.should_not be_nil
      updated_user.password_digest.should_not == user.password_digest
    end

    it "should reload login form if invalid email given" do
      xhr :post, :password_reset, email: 'wrong'
      response.should contain("login_modal_form")
    end

    it "should send email to the right user" do
      user = Factory.create(:user)
      xhr :post, :password_reset, email: user.email
      ActionMailer::Base.deliveries.last.to.should include(user.email)
    end
  end

end
