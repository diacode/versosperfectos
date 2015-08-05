json.array! @posts do |post|
  json.id post.id
  json.title post.title
  json.public_url post_extended_url(post.permalink_hash)
  json.draft post.draft
  json.published_at post.published_at
end
