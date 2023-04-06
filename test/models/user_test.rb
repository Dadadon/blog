require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '  '
    assert_not @user.valid?
  end

  test 'posts_counter should not be negative' do
    @user.posts_counter = -1
    assert_not @user.valid?
  end
end
