class SessionsController < ApplicationController
  skip_before_action :login_required
  def new
  end

  def create
     user = User.find_by(name: session_params[:name])
     
     if user && user.authenticate(session_params[:password])
       session[:user_id] = user.id
       redirect_to users_path, flash: {
         notice: 'ログインしました'
       }
      else
       render :new
     end
  end

  def destroy
    reset_session
    redirect_to users_path, flash: {
      notice: 'ログアウトしました'
    }
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
