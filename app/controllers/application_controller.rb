  #
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_login
    return deny_access unless logged_in?
  end

  def log_in(user)
    session[:user_id] = user.id.to_s
  end

  # Returns true if the user is logged in, nil otherwise.
  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def ensure_current_user
    return deny_access unless permitted?(current_user)
    nil
  end

  def deny_access
    redirect_to root_url, notice: 'Access Denied'
  end

  def check_admin
    return deny_access unless current_user.admin?
  end

  # borrowed from Brian - can't think of a better name
  # checks to see if a user is present, if so is it an admin
  # if yes to either, allow through the gate
  # otherwise treat like guest

  def permitted?(user)
    return false if user.nil?
    # return false if user.is_a?(User::NullUser)
    return true if current_user.admin?
    current_user == user
  end
  helper_method :permitted?
end
