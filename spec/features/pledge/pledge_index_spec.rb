require "rails_helper"

describe "Visit a pledge index page - " do

  it "has all the required attributes" do
    pr = Project.create project_attributes
    pr2 = Project.create project_attributes2
    pl = pr.pledges.create pledge_attributes
    pl2 = pr2.pledges.create pledge_attributes2
    pl3 = pr.pledges.create pledge_attributes3
    visit project_pledges_url(pr)

    expect(page).to have_link pl.name, :href => "mailto:#{pl.email}"
    expect(page).to have_text pl.comment
    expect(page).to have_text pl.pledge
    expect(page).to have_text pl.location

    expect(page).to have_text pl3.location
    expect(page).not_to have_text pl2.pledge
    expect(page).not_to have_text pl2.location
  end

end
