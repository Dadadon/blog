require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET #index" do
    before { get "/users" }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end

    it "If the response body includes correct placeholder text" do
      User.all.each do |user|
        expect(response.body).to include("All Users")
      end
    end
  end

  describe "GET #show" do
    user = User.create(name: 'John Doe', bio: 'Lorem ipsum')

    before { get "/users/#{user.id}" }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "If the response body includes correct placeholder text" do
      expect(response.body).to include("Displays user info")
    end
  end
end

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
      expect(response.body).to include("Displays user posts")
    end
  end

  describe 'GET #show' do
    let(:post) { Post.create(title: 'Displays user individual post', text: 'Text for test post', author: user, comments_counter: 0, likes_counter: 0) }

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