require 'rails_helper'

describe "Signing in" do

  it "rediects to the user's intended page" do
    u = User.create! user_attributes
    visit users_url
    sign_in u
    e(current_path).to eq users_path
  end

end
