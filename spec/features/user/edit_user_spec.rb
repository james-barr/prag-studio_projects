require 'rails_helper'

describe 'Editing a user: ' do

  it "does not save an invalid edit & shows errors" do
    u = User.create! user_attributes
    visit user_path(u)
    click_link "Edit Account"
    fill_in "Name", with: ""
    click_button "Update Account"
    e(current_path).to eq user_path(u)
    e(page).to have_text "errors"
  end

  it "saves a valid edit, redirects to user show with flash" do
    u = User.create! user_attributes
    visit edit_user_path(u)
    fill_in "Name", with: "Carrie"
    click_button "Update Account"
    e(page).to have_text "edited successfully"
    e(current_path).to eq user_path(u)
  end


end
