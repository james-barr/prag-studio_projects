def pledge_attributes(override = {})
  {
    comment: "",
    pledge: 10,
    location: "X",
  }.merge override
end
def pledge_attributes2(override = {})
  {
    comment: "meow meow kitty go bye-bye to the moon cheese",
    pledge: 20,
    location: "NY",
  }.merge override
end
def pledge_attributes3(override = {})
  {
    comment: "",
    pledge: 250,
    location: "OH, California",
  }.merge override
end
