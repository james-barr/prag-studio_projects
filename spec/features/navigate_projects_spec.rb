require "rails_helper"

describe "Navigating Projects" do
  it "navigates from show to index" do
    project = Project.create(project_attributes)

    visit project_url(project)

    click_link "All Projects"

    expect(current_path).to eq(projects_path)
  end

  it "navigates from index to show" do
    project = Project.create(project_attributes)

    visit projects_url

    click_link project.name

    expect(current_path).to eq(project_path(project))
  end

  it "navigates from show to edit" do
    project = Project.create project_attributes

    visit project_url(project)

    click_link "Edit"

    expect(current_path).to eq(edit_project_path(project))
  end

  it "navigates from index to new" do
    visit projects_url

    click_link "Add New Project"

    expect(current_path).to eq(new_project_path)
  end

  it "navigates from new to index via the cancel button" do
    visit new_project_url

    click_link "Cancel"

    expect(current_path).to eq(projects_path)
  end

  it "navigates from project show to pledge index" do
    pr = Project.create project_attributes
    pl = pr.pledges.create pledge_attributes
    visit project_url(pr)
    click_link "View Pledges"
    expect(current_path).to eq project_pledges_path(pr)
  end

  it "navigates from pledge index to project show" do
    pr = Project.create project_attributes
    pl = pr.pledges.create pledge_attributes
    visit project_pledges_url(pr)
    click_link "Back to project"
    expect(current_path).to eq project_path(pr)
  end

  it "navigates from project show to new pledge" do
    pr = Project.create project_attributes
    pl = pr.pledges.create pledge_attributes
    visit project_url(pr)
    click_link "Pledge to project"
    expect(current_path).to eq new_project_pledge_path(pr)
  end

  it "naviages from new pledge to project show" do
    pr = Project.create project_attributes
    pl = pr.pledges.create pledge_attributes
    visit new_project_pledge_url(pr)
    click_link "Cancel"
    expect(current_path).to eq project_path(pr)
  end

  it "navigates from user new to user index with cancel link" do
    visit signup_path
    click_link "Cancel"
    e(current_path).to eq users_path
  end

  it "navigates from projects index to new user through aside" do
    visit projects_path
    click_link "Signup"
    e(current_path).to eq signup_path
  end

  it "navigates from project new to user index through aside" do
    visit new_project_path
    click_link "All Users"
    e(current_path).to eq users_path
  end

  it "navigates from user index to user new via its name" do
    u = User.create! user_attributes
    visit users_path
    click_link u.name
    e(current_path).to eq user_path(u)
  end

end
