class SessionsController < ApplicationController

  def create
    user = User.find_by_username(params[:login]) || User.find_by_email(params[:login])

    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
        cookies.permanent[:permanent_session] = true
        cookies.permanent[:cart_id] = cookies[:cart_id] if cookies[:cart_id]
      else
        cookies[:auth_token] = user.auth_token
      end
      flash[:notice] = "You sucessfully logged in"
      if user.admin?
        redirect_to_by_js users_path
      else
        redirect_to_by_js root_path
      end
    else
      flash.now[:alert] = "Wrong login or password"
      render 'shared/reload_login_form', formats: :js
    end
  end

  def destroy
    cookies.delete(:auth_token) if cookies[:auth_token]
    if cookies[:permanent_session]
      cookies.delete(:permanent_session) 
      cart_id = cookies[:cart_id]
      cookies.delete(:cart_id)
      cookies[:cart_id] = cart_id
    end
    redirect_to root_path, notice: "You sucessfully logged out"
  end

end
