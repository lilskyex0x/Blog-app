require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { User.create(name: 'Lilsnow') }
  describe 'GET #index' do
    before do
      get '/users'
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      expect(response).to have_http_status '200'
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end

    it 'includes placeholder text in the response body' do
      expect(response.body).to include('Placeholder text')
    end
  end
end
