
require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(name: "TestUser", email: "testuser@example.com", password: "password")
    @tag = Tag.create!(name: "TestTag")
    @post = @user.posts.create!(title: "Test Post", body: "Test body", tag_ids: [@tag.id])
  end

  test "should get index" do
    get posts_url, headers: auth_headers_json(@user)
    assert_response :success
    assert_match @post.title, @response.body
  end

  test "should show post" do
    get post_url(@post), headers: auth_headers_json(@user)
    assert_response :success
    assert_match @post.title, @response.body
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: "New Post", body: "New body", tag_ids: [@tag.id] } }, headers: auth_headers_json(@user)
    end
    assert_response :created
  end

  test "should not create post without auth" do
    post posts_url, params: { post: { title: "No Auth", body: "No body", tag_ids: [@tag.id] } }
    assert_response :unauthorized
  end

  test "should update own post" do
    patch post_url(@post), params: { post: { title: "Updated" } }, headers: auth_headers_json(@user)
    assert_response :success
    @post.reload
    assert_equal "Updated", @post.title
  end

  test "should not update others' post" do
    other = User.create!(name: "Other", email: "other@example.com", password: "password")
    patch post_url(@post), params: { post: { title: "Hacked" } }, headers: auth_headers_json(other)
    assert_response :forbidden
  end

  test "should destroy own post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post), headers: auth_headers_json(@user)
    end
    assert_response :success
  end

  test "should not destroy others' post" do
    other = User.create!(name: "Other2", email: "other2@example.com", password: "password")
    delete post_url(@post), headers: auth_headers_json(other)
    assert_response :forbidden
  end

  private
  def auth_headers_json(user)
    post user_session_url, params: { email: user.email, password: "password" }, as: :json
    token = JSON.parse(@response.body)["token"]
    { 'Authorization' => "Bearer #{token}" }
  end
end
