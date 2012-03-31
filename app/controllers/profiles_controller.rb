class ProfilesController < ApplicationController
  before_filter :authorize, only: [:show]

  def create
    @user = User.new(params[:user])
    @user.generate_token(:activation_token)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = "Your user was sucessfully created and activation mail was sent to your email address"
      redirect_to_by_js root_path
    else
      render 'shared/reload_signup_form', formats: :js
    end
  end

  def activate
    user = User.find_by_activation_token(params[:activation_token]) 
    if user && user.activate
      redirect_to root_path, notice: "Your user was sucessfully activated. Now you can login"
    else
      render 'shared/_404', status: 404, layout: false
    end
  end

  def password_reset
    user = User.find_by_email(params[:email])

    if user && user.generate_new_password
      UserMailer.password_reset(user).deliver
      flash[:notice] = "New password was sent to your email"
      redirect_to_by_js root_url 
    else
      flash.now[:alert] = "can't find user with such email"
      render 'shared/reload_login_form', formats: :js
    end
  end

  def show
    @title = "Profile"
    @user = current_user
  end

end
