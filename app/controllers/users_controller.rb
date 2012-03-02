class UsersController < ApplicationController

  def index
    @users = User.order('created_at')
  end

  def new
    @user = User.new
  end

  def create
  end

  def activate
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
