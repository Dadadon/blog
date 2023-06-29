require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    before { get '/users' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'If the response body includes correct placeholder text' do
      User.all.each do |_user|
        expect(response.body).to include('All Users')
      end
    end
  end

  describe 'GET #show' do
    user = User.create(name: 'John Doe', bio: 'Lorem ipsum')

    before { get "/users/#{user.id}" }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    # it 'If the response body includes correct placeholder text' do
    #   expect(response.body).to include('Displays user info')
    # end
  end
end
