require 'rails_helper'

RSpec.describe 'user_show', type: :feature do
  before :each do
    @user1 = User.create(
      name: 'David',
      photo: 'https://unsplash.com/photos/vpwDZgKtgVk',
      bio: 'User1 bio',
      posts_counter: 0
    )
    @post1 = Post.create(author: @user1, title: 'post 1', text: 'new post 1', comments_counter: 0, likes_counter: 0)
    @post2 = Post.create(author: @user1, title: 'post 2', text: 'new post 2', comments_counter: 0, likes_counter: 0)
    @post3 = Post.create(author: @user1, title: 'post 3', text: 'new post 3', comments_counter: 0, likes_counter: 0)
    @post4 = Post.create(author: @user1, title: 'post 4', text: 'new post 4', comments_counter: 0, likes_counter: 0)
    @post5 = Post.create(author: @user1, title: 'post 5', text: 'new post 5', comments_counter: 0, likes_counter: 0)
    @post6 = Post.create(author: @user1, title: 'post 6', text: 'new post 6', comments_counter: 0, likes_counter: 0)
    @post7 = Post.create(author: @user1, title: 'post 7', text: 'new post 7', comments_counter: 0, likes_counter: 0)
    visit user_path(@user1)
  end

  it 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src='#{@user1.photo}']")
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content(@user1.name)
  end

  it 'I can see the user\'s last 3 posts.' do
    expect(page).to have_content(@post5.text)
    expect(page).to have_content(@post6.text)
    expect(page).to have_content(@post7.text)
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end

  it 'I can see the user\'s bio.' do
    expect(page).to have_content(@user1.bio)
  end

  it 'I can see a button that lets me view all of a user\'s posts.' do
    expect(page).to have_content('Show All Posts')
  end

  it "When I click to see all posts, it redirects me to the user's post's index page." do
    click_link 'Show All Posts'
    expect(page).to have_current_path(user_posts_path(@user1))
  end

  it 'When I click on a post, it redirects me to that posts show page.' do
    click_link "#{@post7.title}"
    expect(page).to have_current_path(user_post_path(@user1, @post7))
  end
end
