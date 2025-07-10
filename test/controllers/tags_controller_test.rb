
require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(name: "TestUser", email: "testuser3@example.com", password: "password")
    @tag = Tag.create!(name: "TestTag2")
  end

  test "should get index" do
    get tags_url, headers: auth_headers_json(@user)
    assert_response :success
    assert_match @tag.name, @response.body
  end

  test "should get show" do
    get tag_url(@tag), headers: auth_headers_json(@user)
    assert_response :success
    assert_match @tag.name, @response.body
  end

  test "should not get index without auth" do
    get tags_url
    assert_response :unauthorized
  end

  private
  def auth_headers_json(user)
    post user_session_url, params: { email: user.email, password: "password" }, as: :json
    token = JSON.parse(@response.body)["token"]
    { 'Authorization' => "Bearer #{token}" }
  end
end
