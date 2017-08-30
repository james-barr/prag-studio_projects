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
pr1 = Project.find(1)
pr2 = Project.find(2)
pr3 = Project.find(3)

User.create!([
  {
    name: "Admin",
    email: "a@f",
    username: "admin",
    password: "x",
    password_confirmation: "x",
    admin: true
  },
  {
    name: "Jon",
    email: "j@f",
    username: "jon",
    password: "x",
    password_confirmation: "x",
  },
  {
    name: "Bob",
    email: "b@f",
    username: "bob",
    password: "x",
    password_confirmation: "x",
  },
])
u1 = User.find 1
u2 = User.find 3
u3 = User.find 2

r1 = pr1.pledges.create!(
  comment: "",
  pledge: Pledge::Amount.sample,
  location: "CH",
  user: u2
)
r2 = pr1.pledges.create!(
  comment: "meow meow kitty go bye-bye to the moon cheese",
  pledge: Pledge::Amount.sample,
  location: "DE",
  user: u1
)
r3 = pr2.pledges.create!(
  comment: "Jokes and dogs and yarn and lasers and napping",
  pledge: Pledge::Amount.sample,
  location: "WY",
  user: u1
)

f1 = pr1.follows.create! user: u1
f2 = pr1.follows.create! user: u2
f3 = pr1.follows.create! user: u3
f4 = pr2.follows.create! user: u1
f5 = pr3.follows.create! user: u1

Type.create! ([
  {
    name: "Personal"
  },
  {
    name: "Business"
  },
  {
    name: "Fitness"
  },
  {
    name: "Crafts"
  },
  {
    name: "Gaming"
  },
])

t1 = Type.find 1
t2 = Type.find 2
t3 = Type.find 3
t4 = Type.find 4
t5 = Type.find 5

prt1 = pr1.types = [t1, t2, t5]
prt2 = pr2.types = [t1, t3]
prt3 = pr3.types = [t4, t5]
