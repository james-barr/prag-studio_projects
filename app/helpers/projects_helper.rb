module ProjectsHelper

  def format_pledge_end(project)
    if project.ended?
      content_tag :strong, "Drive has ended!"
    else
      (distance_of_time_in_words Time.now, project.pledging_ends_on) + " remaining"
    end
  end

  def display_image(project)
    if project.image_file_name.blank?
      image_tag("placeholder.png", width: 160, height: 90, class: "left-floated")
    else
      image_tag(project.image_file_name, width: 160, height: 90, class: "left-floated")
    end
  end

  def display_pledge project
    if project.fully_funded?
      content_tag(:strong, "Fully funded!")
    else
      link_to project.remaining_pledge, new_project_pledge_path(project)
    end
  end

end
