class FollowsController < ApplicationController
  before_action :require_signin
  before_action :find_project

  def create
    @follow = @project.follows.new user: current_user
    if @follow.save
      redirect_to @project, notice: "Followed"
    else
      render @project, alert: "Already followed"
    end
  end

  def destroy
    @follow = current_user.follows.find_by project_id: @project
    @follow.delete
    redirect_to @project, alert: "Unfollowed"
  end

private
  def find_project
    @project = Project.find_by!(slug: params[:project_id])
  end

end
