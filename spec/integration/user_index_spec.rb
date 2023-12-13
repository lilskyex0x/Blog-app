require 'rails_helper'

RSpec.describe "User index page", type: :feature do
  before do
    @user1 = User.create!(name: 'user1', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 1)
    @user2 = User.create!(name: 'user2', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 2)
    @post1 = Post.create!(author: @user1, title: 'Post 1', comments_counter: 0, likes_counter: 0)
    @post2 = Post.create!(author: @user2, title: 'Post 2', comments_counter: 0, likes_counter: 0)
    @post3 = Post.create!(author: @user2, title: 'Post 3', comments_counter: 0, likes_counter: 0)
  end

  it 'displays the username of all other users' do
    visit users_path

    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'displays the profile picture for each user' do
    visit users_path

    expect(page).to have_css('img[src*="https://unsplash.com/photos/F_-0BxGuVvo"]')
    expect(page).to have_css('img[src*="https://unsplash.com/photos/F_-0BxGuVvo"]')
  end

  it 'displays the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Number of posts: 1', count: 1)
    expect(page).to have_content('Number of posts: 2', count: 1)
  end

  it 'redirects to user show page when a user is clicked' do
    visit users_path

    click_link @user1.name

    expect(page).to have_current_path(user_path(@user1))
  end
end