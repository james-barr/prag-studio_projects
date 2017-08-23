class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  add_flash_types(:danger)

private

  def require_signin
    unless current_user
      redirect_to signin_url
      flash[:alert] = "You must sign in first"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


end
