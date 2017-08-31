require 'rails_helper'

describe "Filtering Projects" do

  it "returns projects that are still pledging" do
    pr = Project.create! project_attributes pledging_ends_on: Date.tomorrow
    visit filter_projects_path(:pledging)
    e(current_path).to eq "/projects/filter/pledging"
    e(page).to have_text pr.name
  end

  it "returns projects whose pledging has ended" do
    pr = Project.create! project_attributes pledging_ends_on: Date.yesterday
    visit filter_projects_path(:pledging_ended)
    e(current_path).to eq "/projects/filter/pledging_ended"
    e(page).to have_text pr.name
  end


end
