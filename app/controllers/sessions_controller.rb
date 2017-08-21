class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      flash[:notice] = "Welcome back, #{user.name}"
      redirect_to user_path(user)
    else
      flash.now[:alert] = "Error, invalid login credentials"
      render 'new'
    end
  end
end
