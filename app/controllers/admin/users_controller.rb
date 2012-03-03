class Admin::UsersController < Admin::AdminController

  def index
    @users = User.order('created_at')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user], without_protection: true)

    if @user.save
      redirect_to users_path, notice: "user was sucessfully created"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user], without_protection: true)
      redirect_to users_path, notice: "user was sucessfully updated"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path, notice: "user was sucessfully deleted"
  end

end