require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user) { User.create(name: 'John', bio: 'testing') }

  describe 'GET #index' do
    it 'returns http success' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes the post titles in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('Displays user posts')
    end
  end

  describe 'GET #show' do
    let(:post) do
      Post.create(title: 'Displays user individual post', text: 'Text for test post', author: user, comments_counter: 0,
                  likes_counter: 0)
    end

    it 'returns http success' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'includes the post title and text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include(post.title)
    end
  end
end
