require "rails_helper"

describe "Deleting an event (admin)" do

  before do
    @admin = User.create! user_attributes admin: true
    sign_in @admin
  end

  it "deletes and event and redirects to index" do
    project = Project.create project_attributes
    visit project_url(project)
    click_link "Delete Project"
    expect(current_path).to eq(projects_path)
    expect(page).not_to have_text(project.name)
    expect(page).to have_selector "p.flash_danger"
  end

end
