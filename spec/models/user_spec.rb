require 'rails_helper'

RSpec.describe User, type: :model do

  it "is invalid without a name" do
    u = User.new name: ""
    u.v?
    e(u.errors[:name].any?).to eq true
  end

  it "is invalid without an email" do
    u = User.new email: ""
    u.v?
    e(u.errors[:email].any?).to eq true
  end

  it "is invalid without a password" do
    u = User.new password: ""
    u.v?
    e(u.errors[:password].any?).to eq true
  end

  it "is invalid without a password confirmation" do
    u = User.new password: "X", password_confirmation: ""
    u.v?
    e(u.errors[:password_confirmation].any?).to eq true
  end

  it "is invalid without a properly formatted email" do
    u = User.new email: "x"
    u.v?
    e(u.errors[:email].any?).to eq true
  end

  it "is valid with a properly formatted email" do
    u = User.new email: "x@y"
    u.v?
    e(u.errors[:email].any?).to eq false
  end

  it "is invalid if email matches a previously created email (case insensitive)" do
    u1 = User.create! user_attributes email: "x@y"
    u = User.new email: u1.email.upcase
    u.v?
    e(u.errors[:email].any?).to eq true
  end

  it "is invalid with a pw that doesn't match pw_confirm" do
    u = User.new password: "x", password_confirmation: "y"
    u.v?
    e(u.errors[:password_confirmation].any?).to eq true
  end

  it "is invalid with a pw, but not a pw_confirm" do
    u = User.new user_attributes password: "x", password_confirmation: ""
    e(u.v?).to eq false
  end

  it "is valid if all fields are filled out properly" do
    u = User.new user_attributes
    e(u.v?).to eq true
  end

  it "requires password / password_confirm to be present at creation" do
    u = User.create! user_attributes
    e(u.v?).to eq true
  end

  it "creates password_digest at password input" do
    u = User.new password: "x"
    u.v?
    e(u.password_digest).to be_present
  end

  it "is invalid without a username" do
    user = User.new username: ""
    user.v?
    e(user.errors[:username].any?).to eq true
  end

  it "is invalid with an improperly formatted username" do
    user = [',', 'a.c', '!!!!', "abc d", ' ']
    user.each do |u|
      u1 = User.new username: u
      u1.v?
      e(u1.errors[:username].any?).to eq true
    end
  end

  it "is invalid with a repeating username (case-insensitive)" do
    u1 = User.create! user_attributes
    u2 = User.new username: u1.username.downcase
    u2.v?
    e(u2.errors[:username].any?).to eq true
  end

  it "authenticates a valid email / pw combo" do
    u = User.create! user_attributes email: "xx@x", password: "x", password_confirmation: "x"
    e(User.authenticate("xx@x", u.password)).to eq u
  end

  it "does not authenticate a missing username" do
    u = User.create! user_attributes username: "xxx", password: "x1", password_confirmation: "x1"
    e(User.authenticate("", u.password)).not_to eq true
  end

  it "does not authenticate a missing pw" do
    u = User.create! user_attributes email: "xx@x", password: "x1", password_confirmation: "x1"
    e(User.authenticate("xx@x", "")).not_to eq true
  end

  it "has many pledges" do
    u = User.new user_attributes
    pr1 = Project.new project_attributes
    pr2 = Project.new project_attributes
    pl1 = pr1.pledges.new pledge_attributes
    pl1.user = u; pl1.save!
    pl2 = pr2.pledges.new pledge_attributes2
    pl2.user = u; pl2.save!
    e(u.pledges).to include pl1
    e(u.pledges).to include pl2
  end



end
