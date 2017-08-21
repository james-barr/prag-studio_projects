require 'rails_helper'

describe "New session creation: " do

  it "shows all required fields" do
    visit signin_path
    e(page).to have_field "Email"
    e(page).to have_field "Password"
    e(page).to have_selector "input[type='submit']"
    e(page).to have_xpath "//input[@required='required']"
    e(page).to have_link "Sign up"
    e(page).to have_selector "input[type=submit]"
  end

  it "does not authenticate without a password & flashes an error" do
    u = User.create user_attributes email: "x@x", password: "y", password_confirmation: "y"
    visit signin_path
    fill_in "Email or Username", with: "x@x"
    fill_in "Password", with: ""
    click_button "Sign In"
    e(current_path).to eq session_path
    e(page).to have_text "Error"
  end

  it "does not authenticate without a username / email & flashes an error" do
    u = User.create user_attributes email: "x@x", password: "y", password_confirmation: "y"
    visit signin_path
    fill_in "Email or Username", with: ""
    fill_in "Password", with: "y"
    click_button "Sign In"
    e(current_path).to eq session_path
    e(page).to have_text "Error"
  end

  it "authenticates with a good username, redirects, & flashes an msg" do
    u = User.create user_attributes username: "x", password: "y", password_confirmation: "y"
    visit signin_path
    fill_in "Email or Username", with: "x"
    fill_in "Password", with: "y"
    click_button "Sign In"
    e(current_path).to eq user_path(u)
    e(page).to have_text "Welcome back"
  end

  it "authenticates with a good email, redirects, & flashes an msg" do
    u = User.create user_attributes email: "x@x", password: "y", password_confirmation: "y"
    visit signin_path
    fill_in "Email or Username", with: "x@x"
    fill_in "Password", with: "y"
    click_button "Sign In"
    e(current_path).to eq user_path(u)
    e(page).to have_text "Welcome back"
  end

end
