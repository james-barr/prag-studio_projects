require 'rails_helper'

describe "Destroying a session (sign out): " do

  it "destroys the session, redirects, and flashes" do
    u = User.create! user_attributes
    sign_in u
    click_link "Sign Out"
    e(page).to have_link "Sign In"
    e(page).to have_link "Sign Up"
    e(page).not_to have_link "Sign Out"
    e(page).not_to have_link "Account Settings"
    e(current_path).to eq root_path
    e(page).to have_text "You have signed out"
  end

end
