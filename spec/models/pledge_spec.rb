require "rails_helper"

describe "A pledge - " do

  before do
    @u = User.create! user_attributes
  end

  it "invalidates an optional comment that is less than 25 characters" do
    pl = Pledge.new comment: "a"
    pl.valid?
    expect(pl.errors[:comment].any?).to eq true
  end

  it "invalidates an optional comment that is more than 150 characters" do
    pl = Pledge.new comment: "0123456789 0123456789 0123456789 0123456789
    0123456789 0123456789 0123456789 0123456789 0123456789 0123456789
    0123456789 0123456789 0123456789 0123456789 0123456789 0123456789"
    pl.valid?
    expect(pl.errors[:comment].any?).to eq true
  end

  it "validates without an optional comment" do
    pl = Pledge.new comment: ""
    pl.valid?
    expect(pl.errors[:comment].any?).to eq false
  end

  it "rejects an amount that varies from our pre-determined increments" do
    am = [-1, 0, 11, 1.1]
    am.each do |am|
      pl = Pledge.new pledge: am
      pl.valid?
      expect(pl.errors[:pledge].any?).to eq true
    end
  end

  it "validates an amount that is in our pre-determined increments" do
    pl = Pledge.new pledge: Pledge::Amount.sample
    pl.valid?
    expect(pl.errors[:pledge].any?).to eq false
  end

  it "validates that location is present" do
    pl = Pledge.new location: ""
    pl.valid?
    expect(pl.errors[:location].any?).to eq true
  end

  it "is invalid if not assigned to a project" do
    pl = Pledge.new pledge_attributes
    pl.valid?
    expect(pl.errors.any?).to eq true
  end

  it "is a valid submission with good attributes" do
    project = Project.new project_attributes
    pl = Pledge.new pledge_attributes(project: project)
    pl.user = @u
    pl.valid?
    expect(pl.errors.any?).to eq false
  end

end
