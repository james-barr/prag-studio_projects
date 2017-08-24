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

  helper_method :current_user
  helper_method :current_user?

end
