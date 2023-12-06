require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    before do
      User.create(name: 'Lilsnow')
      get :index
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

    it 'includes placeholder text' do
      expect(assigns(:users)).to include(User.find_by(name: 'Lilsnow'))
    end
  end
end