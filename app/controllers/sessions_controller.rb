class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}"
      redirect_to(session[:intended_url] || user)
      session[:intended_url] = nil
    else
      flash.now[:alert] = "Error, invalid login credentials"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, alert: "You have signed out"
  end
end
