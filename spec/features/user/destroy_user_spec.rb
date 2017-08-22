require 'rails_helper'

describe "Destroying a user" do

  it "deletes a user" do
    u = User.create! user_attributes
    visit user_path(u)
    click_link "Delete Account"
    e(current_path).to eq users_path
    e(page).to have_link "Sign In"
    e(page).to have_link "Sign Up"
    e(page).not_to have_link "Sign Out"
    e(page).not_to have_link "Account Settings"
    e(page).to have_text "User deleted"
  end

end
