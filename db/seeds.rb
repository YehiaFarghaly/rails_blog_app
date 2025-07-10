# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
# Clear existing data
Comment.destroy_all
PostTag.destroy_all
Post.destroy_all
Tag.destroy_all
User.destroy_all

# Users
user1 = User.create!(name: "Alice", email: "alice@example.com", password: "password")
user2 = User.create!(name: "Bob", email: "bob@example.com", password: "password")

# Tags
tag1 = Tag.create!(name: "Ruby")
tag2 = Tag.create!(name: "Rails")
tag3 = Tag.create!(name: "API")

# Posts
post1 = user1.posts.create!(title: "First Post", body: "This is Alice's first post.", tag_ids: [tag1.id, tag2.id])
post2 = user2.posts.create!(title: "Bob's Post", body: "Bob writes about APIs.", tag_ids: [tag2.id, tag3.id])

# Comments
post1.comments.create!(content: "Great post, Alice!", user: user2)
post1.comments.create!(content: "Thanks Bob!", user: user1)
post2.comments.create!(content: "Nice API tips.", user: user1)

puts "Seeded users: #{User.count}, tags: #{Tag.count}, posts: #{Post.count}, comments: #{Comment.count}"
