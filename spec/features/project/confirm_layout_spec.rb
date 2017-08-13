require "rails_helper"

describe "Confirming footer's presence" do
  def footer_presence
    expect(page).to have_selector("footer")
  end

  def header_presence
    expect(page).to have_selector('header')
  end

  def aside_presence
    expect(page).to have_selector('aside')
  end


  it "checks the index page" do
    visit projects_url

    footer_presence
    header_presence
    aside_presence
  end

  it "checks the new page" do
    visit new_project_url

    footer_presence
    header_presence
    aside_presence
  end

end
