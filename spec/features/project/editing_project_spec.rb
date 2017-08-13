require "rails_helper"

describe "Editing a project" do
  it "updates the project and shows the project's details" do
    project = Project.create(project_attributes)

    visit edit_project_path(project)

    expect(find_field('Name').value).to eq(project.name)
    expect(find_field('Description').value).to eq(project.description)
    expect(find_field('Website').value).to eq(project.website)
  end

  it "edits the project's name and redirects to the project's show page" do
    project = Project.create project_attributes
    visit edit_project_url(project)
    fill_in "Name", with: "Dummy Project"
    click_button "Update Project"
    expect(current_path).to eq(project_path(project))
    expect(page).to have_text "Dummy Project"
    expect(page).to have_selector "p.flash_notice"
  end

  it "does not update an invalid project" do
    project = Project.create project_attributes
    visit edit_project_url(project)
    fill_in "Name", with: " "
    click_button "Update Project"
    expect(page).to have_text "error"
    expect(current_path).to eq project_path(project)
  end

end
