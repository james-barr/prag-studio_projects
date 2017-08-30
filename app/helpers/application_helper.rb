module ApplicationHelper

  def page_title
    if content_for? :title
      "Projects - #{content_for :title}"
    else
      "Projects"
    end
  end

  def title(object)
    content_for :title, object
  end

end
