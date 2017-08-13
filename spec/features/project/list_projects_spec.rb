require "rails_helper"

describe "visit projects page" do
  it "shows the projects" do
    allow(Time).to receive(:now).and_return(Time.parse("00:00:00"))
    project1 = Project.create project_attributes
    project2 = Project.create project_attributes2
    project3 = Project.create project_attributes3
    project4 = Project.create project_attributes4
    visit projects_url

    expect(page).to have_text "3 Projects"
    expect(page).to have_text project1.name
    expect(page).to have_text project2.name
    expect(page).to have_text project3.name
    expect(page).not_to have_text project4.name

    expect(page).to have_text project1.description
    expect(page).to have_text "1 day remaining"
    expect(page).to have_text project1.target_pledge_amount
    expect(page).to have_text project1.website
    expect(page).to have_text project1.team_members
    expect(page).to have_selector "img[src*=projecta]"
  end
end
