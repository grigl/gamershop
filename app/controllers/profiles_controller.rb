class ProfilesController < ApplicationController

  def new
  end

  def create
    @user = User.new(params[:user])
    @user.generate_token(:activation_token)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = "Your user was sucessfully created and activation mail was sent to your email address"
      redirect_to_by_js root_path
    else
      render 'reload_form.js.erb'
    end
  end

  def activate
    user = User.find_by_activation_token(params[:activation_token]) 
    if user && user.activate
      redirect_to root_path, notice: "Your user was sucessfully activated. Now you can login"
    else
      render status: 404
    end
  end

end
