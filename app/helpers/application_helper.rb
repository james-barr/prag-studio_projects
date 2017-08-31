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

  def nav_link_to(text, url)
    if current_page?(url)
      class1 = "button active"
    else
      class1 = "button"
    end
    link_to text, url, class: class1
  end

end
