require "rails_helper"

describe "Following and unfollowing a project" do

  before do
    @user = User.create! user_attributes
    @project = Project.create! project_attributes
    sign_in @user
    visit project_path @project
  end

  it "doesn't show any buttons if no user is signed in" do
    click_link "Sign Out"
    visit project_path @project
    e(page).not_to have_button "Follow"
    e(page).not_to have_button "Unfollow"
    e(page).to have_text "0 followers"
  end

  it "shows a follow button if user has not followed" do
    expect{
      click_button "Follow"
    }.to change(@project.followers, :count).by 1
    e(page).to have_text "1 follower"
    e(page).not_to have_button "Follow"
    e(page).to have_button "Unfollow"
  end

  it "shows an unfollow button if user has not followed" do
    click_button "Follow"
    expect{
      click_button "Unfollow"
    }.to change(@project.followers, :count).by -1
    e(page).to have_text "0 followers"
    e(page).not_to have_button "Unfollow"
    e(page).to have_button "Follow"
  end

end
