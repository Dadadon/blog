require 'rails_helper'

RSpec.describe 'User index page - ', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'David',
      photo: 'https://unsplash.com/photos/vpwDZgKtgVk',
      bio: 'bio',
      posts_counter: 20
    )
    @user2 = User.create(
      name: 'Dana',
      photo: 'https://unsplash.com/photos/f6HbVnGtNnY',
      bio: 'bio',
      posts_counter: 3
    )
    @user3 = User.create(
      name: 'Rafa',
      photo: 'https://unsplash.com/photos/tZ0-PxVEXtQ',
      bio: 'bio',
      posts_counter: 0
    )
    visit users_path
  end

  it 'Can see the username of all other users' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@user3.name)
  end

  it 'Can see the profile picture for each user' do
    expect(page).to have_css("img[src='#{@user1.photo}']")
  end

  it 'Can see the number of posts each user has written.' do
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user3.posts_counter}")
  end

  it 'When I click on a user, I am redirected to that user\'s show page' do
    click_link @user1.name
    expect(page).to have_current_path(user_path(@user1))
  end
end