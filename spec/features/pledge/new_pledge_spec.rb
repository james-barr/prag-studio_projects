require "rails_helper"

describe "Creating a new pledge - " do

  before do
    @u = User.create! user_attributes
    sign_in @u
  end

  it "saves a valid pledge and redirects with a flash msg" do
    pr = Project.create project_attributes
    visit new_project_pledge_url(pr)
    fill_in "Location", with: "DE"
    fill_in "Comment", with: ""
    select "10", from: "Pledge"
    click_button "Submit Pledge"
    expect(current_path).to eq project_path(pr)
    expect(page).to have_text "Success"
    expect(page).to have_selector "p.flash_success"
  end

  it "does not save an invalid pledge and shows errors" do
    pr = Project.create project_attributes
    pl = pr.pledges.create pledge_attributes
    visit new_project_pledge_url(pr)
    click_button "Submit Pledge"
    expect(current_path).to eq project_pledges_path(pr)
    expect(page).to have_text "error"
    expect(page).to have_selector "header.error"
  end

end
