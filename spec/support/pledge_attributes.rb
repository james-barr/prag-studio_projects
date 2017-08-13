def pledge_attributes(override = {})
  {
    name: "Sean",
    comment: "",
    pledge: 10,
    email: "S@email.com",
    location: "X",
  }.merge override
end
def pledge_attributes2(override = {})
  {
    name: "Markus Smart The 3rd",
    comment: "meow meow kitty go bye-bye to the moon cheese",
    pledge: 20,
    email: "s-1@g.com",
    location: "NY",
  }.merge override
end
def pledge_attributes3(override = {})
  {
    name: "Al",
    comment: "",
    pledge: 250,
    email: "me@c.gov",
    location: "OH, California",
  }.merge override
end
