class ProjectsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :destroy, :update]

  def index
    @projects = Project.send(project_scope)
  end

  def show
    @pledge = @project.pledges.new
    @followers = @project.followers
    if current_user
      @current_follow = current_user.follows.find_by(project_id: @project)
    end
    @types = @project.types
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project successfully updated"
    else
      render :edit
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Project successfully created"
    else
      render :new
    end
  end

  def destroy
    @project.delete
    redirect_to projects_url, danger: "Project successfully deleted"
  end

private

  def project_params
    params.require(:project).permit(:name, :description, :target_pledge_amount,
        :price, :website, :team_members, :image_file_name, type_ids: [])
  end

  def project_scope
    if params[:scope].in? %w(pledging_ended)
      params[:scope]
    else
      :pledging
    end
  end

  def set_event
    @project = Project.find_by!(slug: params[:id])
  end

end
