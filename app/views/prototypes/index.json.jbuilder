json.array! @prototypes do |prototype|
  json.id           prototype.id
  json.image        prototype.set_main_thumbnail.url
  json.title        prototype.title
  json.created_at   prototype.posted_date
  json.user_name    prototype.user.name
  json.user_id      prototype.user_id
  json.tags         prototype.tags
end
