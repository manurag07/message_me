class SessionsController < ApplicationController
  before_action :logged_in_redirect, except: %i[destroy]
  def new; end

  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'You are successfully logged in'
      redirect_to root_path
    else
      flash.now[:error] = 'Your email or password are not correct'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You are successfully logged out'
    redirect_to login_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:error] = 'You are already logged in'
      redirect_to root_path
    end
  end
  # def user_params
  #   params.require(:session).permit(:username, :password)
  # end
end
