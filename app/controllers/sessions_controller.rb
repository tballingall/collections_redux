#
class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    if authenticatable?
      session[:user_id] = user.id
      redirect_to user, notice: 'Logged in!'
    else
      flash.now.alert = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: 'Logged out!'
  end

  private

  def authenticatable?
    user && user.authenticate(params[:user][:password])
  end

  def user
    @user ||= User.find_by_email(params[:user][:email])
  end
end
