json.array! @users do |user|
  json.slack_id user[:slack_id]
  json.user_group_id user[:user_group_id]
  json.name user[:name]
  json.real_name user[:real_name]
  json.profile_picture_url user[:avatar_url]
end
