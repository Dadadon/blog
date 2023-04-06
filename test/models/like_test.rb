require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
    @user = users(:one)
  end


  test 'should not create a like without an author' do
    assert_no_difference('Like.count') do
      @post.likes.create(author_id: nil)
    end
  end
end
