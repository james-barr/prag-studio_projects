class ProjectsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @projects = Project.where("pledging_ends_on >= ?", Time.now).order("pledging_ends_on")
  end

  def show
    @project = Project.find params[:id]
    @pledge = @project.pledges.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
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
    @project = Project.find(params[:id])
    @project.delete
    redirect_to projects_url, danger: "Project successfully deleted"
  end

private

  def project_params
    params.require(:project).permit(:name, :description, :target_pledge_amount,
        :price, :website, :team_members, :image_file_name)
  end

end
