require 'rails_helper'

RSpec.describe 'User Post Index', type: :feature do
  before do
    @user = User.create!(name: 'testuser', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 0)
    @post = @user.posts.create!(title: 'Test Post', text: 'This is a test post.')
    @comment = @post.comments.create!(user: @user, text: 'This is a test comment.')
    @post.likes.create!(user: @user)
  end

  it 'displays the user profile picture and name' do
    visit user_posts_path(@user)

    expect(page).to have_css('img[src*="https://unsplash.com/photos/F_-0BxGuVvo"]')
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    visit user_posts_path(@user)
  
    expect(page).to have_content("Total Posts: #{@user.posts.count}")
  end

  it 'displays a post title, body, comment count, and like count' do
    visit user_posts_path(@user)

    expect(page).to have_link(@post.title, href: user_post_path(@user, @post))
    expect(page).to have_content(@post.text)
    expect(page).to have_content("Likes: #{@post.likes.count}")
    expect(page).to have_content("Comments: #{@post.comments.count}")
  end

  it 'displays the first comments on a post' do
    visit user_posts_path(@user)

    expect(page).to have_content("Comment: #{@comment.text}")
  end

  it 'redirects to the post show page when a post is clicked' do
    visit user_posts_path(@user)

    click_link @post.title

    expect(page).to have_current_path(user_post_path(@user, @post))
  end
end
