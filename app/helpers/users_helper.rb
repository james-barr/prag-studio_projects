module UsersHelper
  def present_created_at(o)
    o.created_at.strftime("%B %e, %Y")
  end
end
