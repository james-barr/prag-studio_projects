module UsersHelper
  def present_created_at(o)
    o.created_at.strftime("%B %e, %Y")
  end

  def gravatar_image(object, options={})
    size = options[:size] || 80
    url = "https://www.gravatar.com/avatar/#{object.gravatar_id}"
    image_tag url, alt: object.name, size: size
  end
end
