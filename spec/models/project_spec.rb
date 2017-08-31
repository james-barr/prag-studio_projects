require "rails_helper"

describe "a project" do
  it "returns 'All Done' if the pledge date has passed" do
    project = Project.new(pledging_ends_on: 100.days.ago)
    expect(project.ended?).to eq(true)
  end

  it "returns the remaining days if the pledge date has not passed" do
    project = Project.new(pledging_ends_on: 100.days.from_now)

    expect(project.ended?).to eq(false)
  end

  it "returns 'All Done' if the pledge date is empty" do
    project = Project.new(pledging_ends_on: nil)

    expect(project.ended?).to eq(true)
  end

  it "displays only the projects that are still in progress, in order of pledge end time" do
    project1 = Project.create(project_attributes(name: "PP", pledging_ends_on: 10.days.ago))
    project2 = Project.create(project_attributes(name: "PA", pledging_ends_on: 10.days.from_now))
    project3 = Project.create(project_attributes(name: "PB", pledging_ends_on: 30.days.from_now))
    project4 = Project.create(project_attributes(name: "PC", pledging_ends_on: 20.days.from_now))

    expect(Project.in_progress).not_to include(project1)
    expect(Project.in_progress.to_a).to eq([project2, project4, project3])
  end

  it "validates that name is present" do
    project = Project.new name: ""
    project.valid?
    expect(project.errors[:name].any?).to eq true
  end

  it "validates that description is at least 25 characters" do
    project = Project.new description: ""
    project.valid?
    expect(project.errors[:description].any?).to eq true
  end

  it "validates that description is no more than 150 characters" do
    project = Project.new description: "0123456789 0123456789 0123456789
     0123456789 0123456789 0123456789 0123456789 0123456789
     0123456789 0123456789 0123456789 0123456789 0123456789 0123456789"
    project.valid?
    expect(project.errors[:description].any?).to eq true
  end

  it "validates that the target pledge amount can be a positive decimal" do
    project = Project.new target_pledge_amount: 100.00
    project.valid?
    expect(project.errors[:target_pledge_amount].any?).to eq false
  end

  it "validates that the target pledge amount cannot be negative" do
    project = Project.new target_pledge_amount: -1
    project.valid?
    expect(project.errors[:target_pledge_amount].any?).to eq true
  end

  it "validates that the target pledge amount can be zero" do
    project = Project.new target_pledge_amount: 0
    project.valid?
    expect(project.errors[:target_pledge_amount].any?).to eq false
  end

  it "validates ba team members matches aren't allowed pattern" do
    team = ["Mark, Sherrie,  3", "Alex,      ", "    Carol", "Al 3, Kim"]
    project = Project.new team_members: team
    project.valid?
    expect(project.errors[:team_members].any?).to eq true
  end

  it "validates that good team members matches are allowed" do
    team = ["J, Carrie Jr", "Sean", "Mike, Molly, Carol Schwek"]
    team.each do |team|
      project = Project.new team_members: team
      project.valid?
      expect(project.errors[:team_members].any?).to eq false
    end
  end

  it "validates that a bad url match is not allowed" do
    urls = ["www.y.com", "www.com", "htp://www.x.com", "http//www.y.com",
      "http:www.c.com", "http://.com", "http://www.y", "http://www.y."]
    urls.each do |url|
      project = Project.new website: url
      project.valid?
      expect(project.errors[:website].any?).to eq true
    end
  end

  it "validates that a good url match is allowed" do
    urls = ["http://www.x.com", "http://www.y-z.net", "http://www.1.org"]
    urls.each do |url|
      project = Project.new website: url
      project.valid?
      expect(project.errors[:website].any?).to eq false
    end
  end

  it "validates that image file name can be blank" do
    project = Project.new image_file_name: ""
    project.valid?
    expect(project.errors[:image_file_name].any?).to eq false
  end

  it "validates that image file fails if not matching regex" do
    image = ["png", "x.j", "qjpg", "y.pdf"]
    image.each do |image|
      project = Project.new image_file_name: image
      project.valid?
      expect(project.errors[:image_file_name].any?).to eq true
    end
  end

  it "validates that image file succeeds if matching regex" do
    image = ["y.jpg", "1.png", "-.GIF"]
    image.each do |image|
      project = Project.new image_file_name: image
      project.valid?
      expect(project.errors[:image_file_name].any?).to eq false
    end
  end

  it "has many pledges" do
    pr = Project.new project_attributes
    pl1 = pr.pledges.new pledge_attributes
    pl2 = pr.pledges.new pledge_attributes2
    pr.valid?
    expect(pr.pledges).to include pl1
    expect(pr.pledges).to include pl2
  end

  it "deletes all associated pledges if it is deleted" do
    u = User.create! user_attributes
    pr = Project.create project_attributes
    pl1 = pr.pledges.new pledge_attributes
    pl1.user = u; pl1.save!
    pr.valid?
    expect{pr.destroy}.to change(Pledge, :count).by(-1)
  end

  it "calculates the total amount pledged to a project as the sum of all the pledges" do
    u = User.create! user_attributes
    u2 = User.create user_attributes
    pr = Project.create project_attributes
    pl1 = pr.pledges.new pledge_attributes pledge: 10
    pl2 = pr.pledges.new pledge_attributes2 pledge: 20
    pl1.user = u; pl1.save!
    pl2.user = u2; pl2.save!
    expect(pr.sum_pledges).to eq 30
  end

  it "calculates the pledge amount outstanding" do
    u = User.create! user_attributes
    u2 = User.create user_attributes
    pr = Project.create project_attributes target_pledge_amount: 25
    pl1 = pr.pledges.new pledge_attributes pledge: 10
    pl1.user = u; pl1.save!
    expect(pr.remaining_pledge).to eq 15
  end

  it "is funded if the target pledge amount has been reached" do
    u = User.create! user_attributes
    pr = Project.create project_attributes target_pledge_amount: 10
    pl1 = pr.pledges.new pledge_attributes pledge: 10
    pl1.user = u; pl1.save!
    expect(pr.fully_funded?).to eq true
  end

  it "is not funded if the target pledge amount has not been reached" do
    u = User.create! user_attributes
    pr = Project.create project_attributes target_pledge_amount: 11
    pl1 = pr.pledges.new pledge_attributes pledge: 10
    pl1.user = u; pl1.save!
    expect(pr.fully_funded?).to eq false
  end

  it "has many followers" do
    u = User.create! user_attributes
    u2 = User.create! user_attributes2
    pr = Project.create project_attributes
    f1 = pr.follows.create! user: u
    f2 = pr.follows.create! user: u2
    e(pr.followers).to include u
    e(pr.followers).to include u2
  end

  it "returns projects with target pledge amounts greater than" do
    pr1 = Project.create! project_attributes target_pledge_amount: 100
    pr2 = Project.create! project_attributes2 target_pledge_amount: 1
    e(Project.target_greater_than 90).to include pr1
    e(Project.target_greater_than 90).not_to include pr2
  end

  it "returns projects with target pledge amounts less than" do
    pr1 = Project.create! project_attributes target_pledge_amount: 1
    pr2 = Project.create! project_attributes2 target_pledge_amount: 100
    e(Project.target_less_than 90).to include pr1
    e(Project.target_less_than 90).not_to include pr2
  end

  it "returns all projects, sorted by name" do
    pr1 = Project.create! project_attributes
    pr2 = Project.create! project_attributes2
    e(Project.find_all).to include pr1
    e(Project.find_all).to include pr2
  end

  it "returns projects created within the past n days" do
    pr1 = Project.create! project_attributes
    pr2 = Project.create! project_attributes2 created_at: Time.now - 300.days
    e(Project.past_n_days 90).to include pr1
    e(Project.past_n_days 90).not_to include pr2
  end

  it "returns projects whose pledging has ended" do
    pr1 = Project.create! project_attributes pledging_ends_on: 1.day.ago
    pr2 = Project.create! project_attributes2 pledging_ends_on: 1.day.from_now
    e(Project.pledging_ended).to include pr1
    e(Project.pledging_ended).not_to include pr2
  end

  it "returns projects whose pledging has not ended" do
    pr1 = Project.create! project_attributes pledging_ends_on: 1.day.from_now
    pr2 = Project.create! project_attributes2 pledging_ends_on: 1.day.ago
    e(Project.pledging).to include pr1
    e(Project.pledging).not_to include pr2
  end


end
