require "rails_helper"

describe "Viewing an individual project" do

  before do
    @u = User.create! user_attributes admin: true
    sign_in @u
  end

  it "Shows the project's details" do
    project = Project.create(project_attributes)
    visit project_url project
    e(page).to have_text project.name
    e(page).to have_text project.description
    e(page).to have_text project.target_pledge_amount
    e(page).to have_text project.website

  end

  it "shows 'All Done' if the pledging drive has ended" do
    project = Project.create project_attributes(pledging_ends_on: 1.day.ago)
    visit project_url project
    e(page).to have_text "Drive has ended!"
  end

  it "shows the number of days until the pledging is done, if days remain" do
    allow(Time).to receive(:now).and_return(Time.parse("00:00:00"))
    project = Project.create project_attributes(pledging_ends_on: 1.day.from_now)
    visit project_url project
    e(page).to have_text("1 day remaining")
  end

  it "shows the default image if none is provided" do
    project = Project.create project_attributes4
    visit project_url(project)
    e(page).to have_selector "img[src*=placeholder]"
  end

  it "shows the selected image for project" do
    project = Project.create project_attributes
    visit project_url(project)
    e(page).to have_selector "img[src*=projecta]"
  end

  it "saves a valid pledge and redirects with a flash msg" do
    pr = Project.create! project_attributes
    visit project_url(pr)
    fill_in "Location", with: "DE"
    fill_in "Comment", with: ""
    select "10", from: "Pledge"
    click_button "Submit Pledge"
    e(current_path).to eq project_path(pr)
    e(page).to have_text "Success"
    e(page).to have_selector "p.flash_success"
  end

  it "does not save an invalid pledge and shows errors" do
    pr = Project.create project_attributes
    pl = pr.pledges.create pledge_attributes
    visit project_url(pr)
    click_button "Submit Pledge"
    e(current_path).to eq project_pledges_path(pr)
    e(page).to have_text "error"
    e(page).to have_selector "header.error"
  end

  it "shows the amount outstanding with a pledge link if the project is not funded" do
    pr = Project.create project_attributes target_pledge_amount: 10
    pl = pr.pledges.create pledge_attributes pledge: 5, user: @u
    visit project_path(pr)
    e(page).to have_link "5", :href=> new_project_pledge_path(pr)
  end

  it "shows 'Fully funded!' without a pledge link if the project is funded" do
    pr = Project.create project_attributes target_pledge_amount: 10
    pl = pr.pledges.create pledge_attributes pledge: 10, user: @u
    visit project_path(pr)
    e(page).to have_text "Fully funded!"
  end

  it "uses a SEO-friendly URL" do
    pr = Project.create! project_attributes
    visit project_path pr
    e(current_path).to eq "/projects/#{pr.slug}"
  end

end
