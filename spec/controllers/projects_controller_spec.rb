require 'rails_helper'

describe ProjectsController do

  before do
    @p = Project.create! project_attributes
  end

  context "not logged in as an admin" do

    before do
      @u = User.create! user_attributes admin: false
      session[:user_id] = @u.id
    end

    it "cannot edit a project" do
      get :edit, params: { id: @p }
      e(response).to redirect_to root_url
    end

    it "cannot update a project" do
      patch :update, params: { id: @p }
      e(response).to redirect_to root_url
    end

    it "cannot destroy a project" do
      delete :destroy, params: { id: @p }
      e(response).to redirect_to root_url
    end

    it "cannot create project" do
      post :create
      e(response).to redirect_to root_url
    end

    it "cannot 'get' new project" do
      get :new
      e(response).to redirect_to root_url
    end

  end

end
