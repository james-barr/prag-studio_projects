require "rails_helper"

describe "Visit pledge index page - " do

  before do
    @u1 = User.create! user_attributes
    @u2 = User.create! user_attributes2
    @u3 = User.create! user_attributes3
    sign_in @u1
  end

  it "has all the required attributes" do
    pr = Project.create project_attributes
    pr2 = Project.create project_attributes2
    pl = pr.pledges.create pledge_attributes user: @u1
    pl2 = pr2.pledges.create pledge_attributes2 user: @u2
    pl3 = pr.pledges.create pledge_attributes3 user: @u3
    visit project_pledges_url(pr)
    expect(page).to have_text pl.comment
    expect(page).to have_text pl.pledge
    expect(page).to have_text pl.location
    expect(page).to have_text pl3.location
    expect(page).not_to have_text pl2.pledge
    expect(page).not_to have_text pl2.location
  end

end
