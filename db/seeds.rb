# Delete all existing users
User.delete_all

# Create 5 users
(1..5).each do |i|
  User.create(
    name: Faker::Name.name,
    bio: Faker::Lorem.sentence,
    photo: "user#{i}.jpg"
  )
end

# Create some posts for each user
User.all.each do |user|
  rand(1..5).times do
    user.posts.create(
      title: Faker::Lorem.sentence(word_count: 3),
      text: Faker::Lorem.paragraph,
      comments_counter: 0,
      likes_counter: 0
    )
  end
end

# Create some comments and likes for each post
Post.all.each do |post|
  rand(1..5).times do
    post.comments.create(
      text: Faker::Lorem.sentence,
      user_id: User.pluck(:id).sample
    )
    post.likes.create(
      user_id: User.pluck(:id).sample
    )
  end
end