require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create!(name: 'lilsnow') }
  let(:post) { user.posts.create!(title: 'Depressing kid', comments_counter: 0, likes_counter: 0, author_id: user.id) }

  describe 'GET /index' do
    it 'should be response successull' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:ok)
    end

    it 'should render the posts index file' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'should include the placeholder' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET /show' do
    it 'should be a successfull response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'should render the posts show file' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template('posts/show')
    end

    it 'should include the placeholder text' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Placeholder text')
    end
  end
end
