class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: [:edit, :show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end 

  def new
    @user = User.new
  end
  
  def create
    if @user.save
      redirect_to @user, notice: "User created successfully"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end 

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User updated successfully"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User deleted successfully"
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end 

  def set_user
    @user = User.find(params[:id])
  end 
end
