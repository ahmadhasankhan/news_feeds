json.comments comments do |comment|
  json.type comment.class.name
  json.partial! 'newsfeed/user', user: comment.user
  json.content comment.content
end
