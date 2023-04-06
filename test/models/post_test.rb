require 'test_helper'
class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @post = Post.new(title: "Test Post", text: "Test post body", author: @user)
  end


  test "title should be present" do
    @post.title = ""
    assert_not @post.valid?
  end

  test "title should not be too long" do
    @post.title = "a" * 251
    assert_not @post.valid?
  end

  test "comments_counter should be greater than or equal to 0" do
    @post.comments_counter = -1
    assert_not @post.valid?
  end

  test "likes_counter should be greater than or equal to 0" do
    @post.likes_counter = -1
    assert_not @post.valid?
  end

end
