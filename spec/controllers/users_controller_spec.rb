require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @u = User.create! user_attributes
  end

  context "when logged out" do

    before(:each) do
      session[:user_id] = nil
    end

    it "does not allow access to index" do
      get :index
      e(response).to redirect_to signin_url
    end

    it "does not allow access to edit" do
      get :edit, params: { id: @u }
      e(response).to redirect_to signin_url
    end

    it "does not allow access to update" do
      patch :update, params: { id: @u }
      e(response).to redirect_to signin_url
    end

    it "does not allow access to show" do
      get :show, params: { id: @u }
      e(response).to redirect_to signin_url
    end

    it "does not allow access to destroy" do
      delete :destroy, params: { id: @u }
      e(response).to redirect_to signin_url
    end



  end

end
