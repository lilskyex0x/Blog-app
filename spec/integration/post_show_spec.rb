require 'rails_helper'

RSpec.describe "Post show page", type: :feature do
  before do
    @user = User.create(name: 'Test User', posts_counter: 0)
    @post = @user.posts.create(title: 'Test Post', text: 'This is a test post.')
    @comment = @post.comments.create(user: @user, text: 'This is a test comment.')
  end

  it "displays the post's title" do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.title)
  end

  it "displays who wrote the post" do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@user.name)
  end

  it "displays how many comments it has" do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.comments.count)
  end

  it "displays how many likes it has" do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.likes.count)
  end

  it "displays the post body" do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.text)
  end

  it "displays the username of each commenter" do
    visit user_post_path(user_id: @user.id, id: @post.id)
    @post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it "displays the comment each commenter left" do
    visit user_post_path(user_id: @user.id, id: @post.id)
    @post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end