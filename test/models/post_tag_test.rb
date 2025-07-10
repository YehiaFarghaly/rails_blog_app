
require "test_helper"

class PostTagTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(name: "TestUser", email: "ptuser@example.com", password: "password")
    @post = @user.posts.create!(title: "Title", body: "Body")
    @tag = Tag.create!(name: "TagPT")
  end

  test "valid post_tag" do
    pt = PostTag.new(post: @post, tag: @tag)
    assert pt.valid?
  end

  test "invalid without post" do
    pt = PostTag.new(tag: @tag)
    assert_not pt.valid?
  end

  test "invalid without tag" do
    pt = PostTag.new(post: @post)
    assert_not pt.valid?
  end
end
