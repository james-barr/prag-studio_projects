require 'rails_helper'

describe "Index of users: " do

  it "displays all attributes of all users" do
    u1 = User.create! user_attributes
    u2 = User.create! user_attributes2
    u3 = User.create! user_attributes3
    sign_in u1
    visit users_path
    e(page).to have_text "User Index"
    e(page).to have_text u1.name
    e(page).to have_text u2.email
    e(page).to have_text u2.username
    e(page).to have_text u3.name
    e(page).to have_text present_created_at u3
  end

end
