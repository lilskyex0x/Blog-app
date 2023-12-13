require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before do
    @user = User.create!(name: 'user1', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'This is a bio',
                         posts_counter: 3)
    @post1 = Post.create!(author: @user, title: 'Post 1', comments_counter: 0, likes_counter: 0)
    @post2 = Post.create!(author: @user, title: 'Post 2', comments_counter: 0, likes_counter: 0)
    @post3 = Post.create!(author: @user, title: 'Post 3', comments_counter: 0, likes_counter: 0)
  end

  it 'displays the user profile picture' do
    visit user_path(@user)

    expect(page).to have_css('img[src*="https://unsplash.com/photos/F_-0BxGuVvo"]')
  end

  it 'displays the user username' do
    visit user_path(@user)

    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    visit user_path(@user)

    expect(page).to have_content('Number of posts: 3')
  end

  it 'displays the user bio' do
    visit user_path(@user)

    expect(page).to have_content(@user.bio)
  end

  it 'displays the user first 3 posts' do
    visit user_path(@user)

    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
  end

  it 'redirects to post show page when a post is clicked' do
    visit user_path(@user)

    click_link @post1.title

    expect(page).to have_current_path(user_post_path(@user, @post1))
  end

  it 'displays a button to view all posts' do
    visit user_path(@user)
  
    expect(page).to have_link('View All Posts')
  end

  it 'redirects to user posts index page when view all posts button is clicked' do
    visit user_path(@user)

    click_link 'View All Posts'

    expect(page).to have_current_path(user_posts_path(@user))
  end
end
