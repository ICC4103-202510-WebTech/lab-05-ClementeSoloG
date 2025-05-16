class UsersController < ApplicationController
    before_action :set_user, only: [ :edit, :show, :update, :destroy]
    def index
        @users = User.all
    end
    def show
    end 

    def new
        @user = User.new
    end
    
    def create
        @user = User.new user_params
        if @user.save
            flash[:notice] = "Succesfully saved"
            redirect_to user_path(@user), notice: "User created succesfully"
        else 
            flash[:alert] = "#{@user.errors.full_messages.join(", ")}"
            redirect_to new_user_path
        end

    end

    def edit
    end 

    def update
        if @user.update user_params
            redirect_to user_path(@user)
        else
            redirect_to edit_user_path(@user)
        end
    end

    def destroy
        @user.destroy
        redirect_to users_path
    end
    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email)
    end 

    def set_user
        @user = User.find(params["id"])
    end 
end 