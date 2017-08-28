require "rails_helper"

describe "Navigating" do

  before do
    @admin = User.create! user_attributes admin: true
    sign_in @admin
    @pr = Project.create! project_attributes
    @pl = @pr.pledges.create pledge_attributes
  end

  context "logged in as admin, looking at projects" do

    it "navigates from show to index" do
      visit project_url(@pr)
      click_link "All Projects"
      e(current_path).to eq(projects_path)
    end

    it "navigates from show to edit" do
      visit project_url(@pr)
      click_link "Edit"
      e(current_path).to eq(edit_project_path(@pr))
    end

    it "navigates from new to index via the cancel button" do
      visit new_project_url
      click_link "Cancel"
      e(current_path).to eq(projects_path)
    end

    it "navigates from index to new" do
      visit projects_url
      click_link "Add New Project"
      e(current_path).to eq(new_project_path)
    end

  end

  it "navigates from index to show" do
    visit projects_url
    click_link @pr.name
    e(current_path).to eq(project_path(@pr))
  end

  it "navigates from project show to pledge index" do
    visit project_url(@pr)
    click_link "View Pledges"
    e(current_path).to eq project_pledges_path(@pr)
  end

  it "navigates from pledge index to project show" do
    visit project_pledges_url(@pr)
    click_link "Back to project"
    e(current_path).to eq project_path(@pr)
  end

  it "navigates from project show to new pledge" do
    visit project_url(@pr)
    click_link "Pledge to project"
    e(current_path).to eq new_project_pledge_path(@pr)
  end

  it "naviages from new pledge to project show" do
    visit new_project_pledge_url(@pr)
    click_link "Cancel"
    e(current_path).to eq project_path(@pr)
  end

  it "navigates from user new to user index with cancel link" do
    visit signup_path
    click_link "Cancel"
    e(current_path).to eq root_path
  end

  it "navigates from projects index to new user through aside" do
    visit projects_path
    click_link "Sign Out"
    click_link "Sign Up"
    e(current_path).to eq signup_path
  end

  it "navigates from project new to user index through aside" do
    visit new_project_path
    click_link "All Users"
    e(current_path).to eq users_path
  end

  it "navigates from user index to user new via its name" do
    visit users_path
    click_link @admin.name, match: :first
    e(current_path).to eq user_path(@admin)
  end

  it "navigates from user show to user edit" do
    visit user_path(@admin)
    click_link "Edit Account"
    e(current_path).to eq edit_user_path(@admin)
  end

  it "navigates from projects index to signin" do
    visit projects_path
    click_link "Sign Out"
    click_link "Sign In"
    e(current_path).to eq signin_path
  end

  it "navigates from signin to signup" do
    visit signin_path
    click_link "Sign up"
    e(current_path).to eq signup_path
  end

end
