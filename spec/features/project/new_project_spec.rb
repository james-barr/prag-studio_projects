require "rails_helper"

describe "Creating new project (admin)" do

  before do
    @admin = User.create! user_attributes admin: true
    sign_in @admin
    @t1 = Type.create! name: "T1"
    @t2 = Type.create! name: "T2"
    @t3 = Type.create! name: "T3"
  end

  it "has all required fields, creates a project, and redirects to the show page" do
    visit new_project_url
    e(page).to have_text "Adding New Project"
    fill_in "Name", with: "New Project"
    fill_in "Description", with: "Some new project with the required length"
    fill_in "Website", with: "http://www.newproject.com"
    fill_in "Target pledge amount", with: 400
    fill_in "Team members", with: "Alex Jr"
    select (Time.now.year - 1).to_s, :from => "project_pledging_ends_on_1i"
    check @t1.name
    check @t2.name
    click_button "Create Project"
    e(current_path).to eq(project_path(Project.last))
    e(page).to have_text "New Project"
    e(page).to have_selector "p.flash_notice"
    within "aside#sidebar" do
      e(page).to have_text @t1.name
      e(page).to have_text @t2.name
    end
    e(page).not_to have_text @t3.name
    e(page).to have_title "Projects - New Project"
  end

  it "does not save new event that is invalid" do
    visit new_project_url
    click_button "Create Project"
    e(page).to have_text "error"
    e(current_path).to eq projects_path
  end


end
