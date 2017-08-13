def project_attributes(override = {})
  {
    name: "Project A",
    description: "The A-Team's project A is the apex of Projects",
    target_pledge_amount: 200.00,
    pledging_ends_on: 1.day.from_now,
    website: "http://www.project-a.com",
    team_members: "John, Frank",
    image_file_name: "projecta.png"
  }.merge(override)
end

def project_attributes2( override = {} )
  {
    name: "Project B",
    description: "Project B is the Plan B of projects. Backups wanted.",
    target_pledge_amount: 20.00,
    pledging_ends_on: 1001.days.from_now,
    website: "http://www.project-b.com",
    team_members: "Alexa",
    image_file_name: "projectb.png"
  }.merge override
end

def project_attributes3 (override = {} )
  {
    name: "Project C",
    description: "It's the project labeled C... is the label for the project",
    target_pledge_amount: 15000.00,
    pledging_ends_on: 21.days.from_now,
    website: "http://www.project-c.com",
    team_members: "Brian, Carl, and Kris",
    image_file_name: "projectc.png"
  }.merge override
end

def project_attributes4 (override = {} )
  {
    name: "Project Z",
    description: "Shh, this is the last project. It's the worst one we have.",
    target_pledge_amount: 1000.00,
    pledging_ends_on: 21.days.ago,
    website: "http://www.project-z.com",
    team_members: "J, Al"
  }.merge override
end
