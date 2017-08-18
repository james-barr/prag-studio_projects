module UsersHelper
  def present_created_at(o)
    o.created_at.strftime("%B %e, %Y")
  end

  def gravatar_image(o)
    hash = Digest::MD5.hexdigest o.email
    url = "https://www.gravatar.com/avatar/#{hash}"
  end
end
