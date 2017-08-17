require 'rails_helper'

describe "Showing a user: " do

  it "shows all account info" do
    u = User.create! user_attributes
    visit user_path(u)
    e(page).to have_text u.name
    e(page).to have_text u.email
    e(page).to have_text present_created_at u
  end

end
