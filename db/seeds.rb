# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Project.create! ([
  {
    name: "Project A",
    description: "Meow said the dog who was confused by the cat",
    target_pledge_amount: 200.00,
    pledging_ends_on: 600.days.from_now,
    website: "http://www.project-a.com",
    team_members: "John, Frank",
    image_file_name: "projecta.png"
  },
  {
    name: "Project B",
    description: "Woof said the cat in response to the dog",
    target_pledge_amount: 300.00,
    pledging_ends_on: 700.days.from_now,
    website: "http://www.project-b.com",
    team_members: "Alexa",
    image_file_name: "projectb.png"
  },
  {
    name: "Project C",
    description: "Tweet is the action taken by the star in his car",
    target_pledge_amount: 450.00,
    pledging_ends_on: 800.days.from_now,
    website: "http://www.project-c.com",
    team_members: "Brian, Carl, and Kris",
    image_file_name: "projectc.png"
  }
])
pr = Project.find(1)
pr2 = Project.find(2)
r1 = pr.pledges.create!(
  name: "Sean",
  comment: "",
  pledge: Pledge::Amount.sample,
  email: "S@email.com",
  location: "CH",
)
r2 = pr.pledges.create!(
  name: "Markus Smart The 3rd",
  comment: "meow meow kitty go bye-bye to the moon cheese",
  pledge: Pledge::Amount.sample,
  email: "s-1@g.com",
  location: "DE",
)
r3 = pr2.pledges.create!(
  name: "Cat Williams",
  comment: "Jokes and dogs and yarn and lasers and napping",
  pledge: Pledge::Amount.sample,
  email: "cat@g.c",
  location: "WY",
)

User.create!([
  {
    name: "al",
    email: "al@g.com",
    password: "X",
    password_confirmation: "X",
  },
  {
    name: "Mike",
    email: "m@g",
    password: "M",
    password_confirmation: "M",
  },
  {
    name: "Yesim",
    email: "yess@y.com",
    password: "X1",
    password_confirmation: "X1",
  },
  ])
