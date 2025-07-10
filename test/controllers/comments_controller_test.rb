
require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(name: "TestUser", email: "testuser2@example.com", password: "password")
    @post = @user.posts.create!(title: "Test Post", body: "Test body")
    @comment = @post.comments.create!(body: "Test comment", user: @user)
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post post_comments_url(@post), params: { comment: { body: "New comment" } }, headers: auth_headers_json(@user)
    end
    assert_response :created
  end

  test "should not create comment without auth" do
    post post_comments_url(@post), params: { comment: { body: "No auth" } }
    assert_response :unauthorized
  end

  test "should update own comment" do
    patch post_comment_url(@post, @comment), params: { comment: { body: "Updated" } }, headers: auth_headers_json(@user)
    assert_response :success
    @comment.reload
    assert_equal "Updated", @comment.body
  end

  test "should not update others' comment" do
    other = User.create!(name: "Other", email: "other3@example.com", password: "password")
    patch post_comment_url(@post, @comment), params: { comment: { body: "Hacked" } }, headers: auth_headers_json(other)
    assert_response :forbidden
  end

  test "should destroy own comment" do
    assert_difference('Comment.count', -1) do
      delete post_comment_url(@post, @comment), headers: auth_headers_json(@user)
    end
    assert_response :success
  end

  test "should not destroy others' comment" do
    other = User.create!(name: "Other2", email: "other4@example.com", password: "password")
    delete post_comment_url(@post, @comment), headers: auth_headers_json(other)
    assert_response :forbidden
  end

  private
  def auth_headers_json(user)
    post user_session_url, params: { email: user.email, password: "password" }, as: :json
    token = JSON.parse(@response.body)["token"]
    { 'Authorization' => "Bearer #{token}" }
  end
end
