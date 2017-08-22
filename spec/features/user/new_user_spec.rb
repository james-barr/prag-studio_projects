require 'rails_helper'

describe "New user creation: " do

  it "is invalid and displays errors if invalid field(s) exist" do
    visit signup_path
    click_button "Create Account"
    e(current_path).to eq users_path
    e(page).to have_text "error"
  end

  it "is creates user if valid, redirects to index, and displays flash" do
    visit signup_path
    fill_in "Name", with: "Al"
    fill_in "Email", with: "x@g.com"
    fill_in "Username", with: "alx"
    fill_in "Password", with: "meow"
    fill_in "Confirm Password", with: "meow"
    click_button "Create Account"
    e(current_path).to eq user_path(User.last)
    e(page).to have_text "created successfully"
    e(page).to have_link "Al"
    e(page).to have_link "Account Settings"
    e(page).not_to have_link "Sign In"
    e(page).not_to have_link "Sign Up"
  end

end
