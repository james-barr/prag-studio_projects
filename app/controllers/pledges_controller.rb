class PledgesController < ApplicationController
  before_action :require_signin
  before_action :set_project

  def index
    @pledges = @project.pledges
  end

  def new
    @pledge = @project.pledges.new
  end

  def create
    @pledge = @project.pledges.new(pledge_params)
    @pledge.user = current_user
    if @pledge.save
      flash[:success] = "Success! You've pledged to this project."
      redirect_to project_path(@project)
    else
      render :new
    end
  end

private

  def pledge_params
    params.require(:pledge).permit(:name, :email, :location, :pledge, :comment)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end
