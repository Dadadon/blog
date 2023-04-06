require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @post = posts(:one)
    @comment = Comment.new(text: "Test comment", author: @user, post: @post)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "text should be present" do
    @comment.text = ""
    assert_not @comment.valid?
  end
end
