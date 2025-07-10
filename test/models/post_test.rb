
require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(name: "TestUser", email: "postuser@example.com", password: "password")
    @tag = Tag.create!(name: "Tag1")
  end

  test "valid post" do
    post = @user.posts.new(title: "Title", body: "Body", tag_ids: [@tag.id])
    assert post.valid?
  end

  test "invalid without title" do
    post = @user.posts.new(body: "Body", tag_ids: [@tag.id])
    assert_not post.valid?
  end

  test "invalid without body" do
    post = @user.posts.new(title: "Title", tag_ids: [@tag.id])
    assert_not post.valid?
  end

  test "invalid without tags" do
    post = @user.posts.new(title: "Title", body: "Body")
    assert_not post.valid?
  end
end
