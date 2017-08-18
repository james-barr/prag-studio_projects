def user_attributes override = {}
  {
    name: "Al",
    email: "a@c",
    username: "alb",
    password: "x",
    password_confirmation: "x"
  }.merge override
end
def user_attributes2 override = {}
  {
    name: "Alex",
    email: "alex@ch",
    username: "alex",
    password: "x",
    password_confirmation: "x"
  }.merge override
end
def user_attributes3 override = {}
  {
    name: "Carol",
    email: "carol@c",
    username: "cc",
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

def gravatar_image(o)
  "https://www.gravatar.com/avatar/#{o.gravatar_id}"
end
