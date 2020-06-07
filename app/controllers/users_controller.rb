class UsersController < ApplicationController
    def index
      @users = User.all
    end
  
    def new
      @user = User.new
    end
  
    def create
      user = User.new(user_params)
  
      if user.save
        redirect_to users_path, flash:{
          notice: "#{user.name}を登録しました"
        }
      else
        redirect_to　new_user_path
      end
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      user = User.find(params[:id])
      user.update(user_params)
      redirect_to user
    end
  
    def destroy
      user = User.find(params[:id])
      user.destroy
      redirect_to users_path
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :admin, :password, :password_confirmation)
    end
  end
  