# Create some users
5.times do
    User.create(
      name: Faker::Name.name,
      photo: Faker::Internet.url,
      bio: Faker::Lorem.paragraph
    )
  end
  
  # Create some posts for each user
  User.all.each do |user|
    3.times do
      user.posts.create(
        title: Faker::Lorem.sentence,
        text: Faker::Lorem.paragraph,
        comments_counter: 0,
        likes_counter: 0
      )
    end
  end
  
  # Create some comments and likes for each post
  Post.all.each do |post|
    5.times do
      post.comments.create(
        text: Faker::Lorem.sentence,
        user_id: User.pluck(:id).sample
      )
      post.likes.create(
        user_id: User.pluck(:id).sample
      )
    end
    post.update(
      comments_counter: post.comments.count,
      likes_counter: post.likes.count
    )
  end
  
  # Update posts_counter for each user
  User.all.each do |user|
    user.update(posts_counter: user.posts.count)
  end