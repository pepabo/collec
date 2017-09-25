json.array! @usergroups do |usergroup|
  json.team_id usergroup[:team_id]
  json.name usergroup[:name]
  json.description usergroup[:description]
  json.handle usergroup[:handle]
end
