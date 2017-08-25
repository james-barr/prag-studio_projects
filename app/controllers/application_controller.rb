class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types(:danger)

private

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_url
      flash[:alert] = "You must sign in first"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user? user
    current_user == user
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Unauthorized access"
    end
  end

  def current_user_admin?
    current_user.admin?
  end

  def current_user_or_admin? user
    (current_user?(user)) || current_user_admin?
  end


  helper_method :current_user
  helper_method :current_user?
  helper_method :current_user_or_admin?

end
