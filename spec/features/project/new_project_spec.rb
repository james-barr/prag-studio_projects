require "rails_helper"

describe "Creating new project" do
  it "has all required fields, creates a project, and redirects to the show page" do
    visit new_project_url
    expect(page).to have_text "Adding New Project"
    fill_in "Name", with: "New Project"
    fill_in "Description", with: "Some new project with the required length"
    fill_in "Website", with: "http://www.newproject.com"
    fill_in "Target pledge amount", with: 400
    fill_in "Team members", with: "Alex Jr"
    select (Time.now.year - 1).to_s, :from => "project_pledging_ends_on_1i"
    click_button "Create Project"
    expect(current_path).to eq(project_path(Project.last))
    expect(page).to have_text "New Project"
    expect(page).to have_selector "p.flash_notice"
  end

  it "does not save new event that is invalid" do
    visit new_project_url
    click_button "Create Project"
    expect(page).to have_text "error"
    expect(current_path).to eq projects_path
  end


end
