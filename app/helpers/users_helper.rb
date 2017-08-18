module UsersHelper
  def present_created_at(o)
    o.created_at.strftime("%B %e, %Y")
  end

  def gravatar_image(o)
    "https://www.gravatar.com/avatar/#{o.gravatar_id}"
  end
end
