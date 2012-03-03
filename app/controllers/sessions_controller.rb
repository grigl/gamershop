class SessionsController < ApplicationController

  def create
    user = User.find_by_username(params[:login]) || User.find_by_email(params[:login])

    if user && user.authenticate(params[:password])
      session[:auth_token] = user.auth_token
      flash[:notice] = "You sucessfully logged in"
      redirect_to_by_js root_path
    else
    end
  end

end
