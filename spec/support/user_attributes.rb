def user_attributes override = {}
  {
    name: "Al",
    email: "a@c",
    password: "x",
    password_confirmation: "x"
  }.merge override
end
def user_attributes2 override = {}
  {
    name: "Alex",
    email: "alex@ch",
    password: "x",
    password_confirmation: "x"
  }.merge override
end
def user_attributes3 override = {}
  {
    name: "Carol",
    email: "carol@c",
    password: "Y",
    password_confirmation: "Y"
  }.merge override
end


public

def v?
  valid?
end

def e(*args)
  expect(*args)
end

def present_created_at(o)
  o.created_at.strftime("%B %e, %Y")
end
