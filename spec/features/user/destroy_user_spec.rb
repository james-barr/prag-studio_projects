require 'rails_helper'

describe "Destroying a user" do

  it "deletes a user" do
    u = User.create! user_attributes
    visit user_path(u)
    click_link "Delete Account"
    e(current_path).to eq users_path
  end

end
