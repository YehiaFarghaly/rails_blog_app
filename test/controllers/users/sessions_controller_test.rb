
require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(name: "TestUser", email: "testuser4@example.com", password: "password")
  end

  test "should login with valid credentials" do
    post user_session_url, params: { email: @user.email, password: "password" }, as: :json
    assert_response :success
    assert JSON.parse(@response.body)["token"].present?
  end

  test "should not login with invalid credentials" do
    post user_session_url, params: { email: @user.email, password: "wrong" }, as: :json
    assert_response :unauthorized
  end

  test "should logout" do
    post user_session_url, params: { email: @user.email, password: "password" }, as: :json
    token = JSON.parse(@response.body)["token"]
    delete destroy_user_session_url, headers: { 'Authorization' => "Bearer #{token}" }
    assert_response :success
  end
end
