require "rails_helper"

describe PledgesController do

  context "not signed in" do

    before do
      @pr = Project.create! project_attributes
    end

    it "cannot access new" do
      get :new, params: { project_id: @pr }
      e(response).to redirect_to signin_url
    end

    it "cannot access create" do
      post :create, params: { project_id: @pr }
      e(response).to redirect_to signin_url
    end

    it "cannot access index" do
      get :index, params: { project_id: @pr }
      e(response).to redirect_to signin_url
    end

  end

end
