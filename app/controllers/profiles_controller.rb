class ProfilesController < ApplicationController

  def new
    @user = User.new
  end

end