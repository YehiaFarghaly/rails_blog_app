
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(name: "TestUser", email: "commentuser@example.com", password: "password")
    @post = @user.posts.create!(title: "Title", body: "Body")
  end

  test "valid comment" do
    comment = @post.comments.new(body: "Nice!", user: @user)
    assert comment.valid?
  end

  test "invalid without body" do
    comment = @post.comments.new(user: @user)
    assert_not comment.valid?
  end

  test "invalid without user" do
    comment = @post.comments.new(body: "Nice!")
    assert_not comment.valid?
  end
end
