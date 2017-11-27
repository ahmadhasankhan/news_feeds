json.type post.class.name
json.content post.content
json.partial! 'newsfeed/user', user: post.user
json.partial! 'newsfeed/comment', comments: post.comments
