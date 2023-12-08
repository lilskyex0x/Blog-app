# Delete all existing users
User.delete_all

# Create 5 users
users = [
  { name: "Eichi", bio: "Eichi is very popular among web developers. Her smile kills people", photo: "user1.jpg" },
  { name: "Violux", bio: "She's a DJ who always make crowd go wild", photo: "user2.jpg" },
  { name: "Wade", bio: "Wade is a professior at Cambridge university. His mathematics make people question about their lives", photo: "user3.jpg" },
  { name: "Judie", bio: "She's a model from Vogue. A sexy one. People scream their heart out for her.", photo: "user4.jpg" },
  { name: "Eddie", bio: "He's just a desperate kid but plot twist? He is spider-man", photo: "user5.jpg" },
]

# Create each user
users.each do |user_data|
  User.create(user_data)
end

# Create some posts for each user
User.all.each do |user|
  5.times do |i|
    post = user.posts.create(
      title: "Post #{i+1} by #{user.name}",
      text: "This is post #{i+1} by #{user.name}",
      comments_counter: 0,
      likes_counter: 0
    )

    # Create some comments for each post
    rand(1..5).times do |j|
      post.comments.create(
        text: "Comment #{j+1} on #{post.title}",
        user_id: User.pluck(:id).sample
      )
    end

    # Create some likes for each post
    rand(1..5).times do
      post.likes.create(
        user_id: User.pluck(:id).sample
      )
    end

    # Update comments_counter and likes_counter for the post
    post.update(
      comments_counter: post.comments.count,
      likes_counter: post.likes.count
    )
  end
end