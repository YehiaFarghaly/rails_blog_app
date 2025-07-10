
require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should register user" do
    assert_difference('User.count') do
      post user_registration_url, params: { user: { name: "NewUser", email: "newuser@example.com", password: "password" } }, as: :json
    end
    assert_response :success
    assert JSON.parse(@response.body)["token"].present?
  end

  test "should not register with invalid data" do
    post user_registration_url, params: { user: { name: "", email: "", password: "" } }, as: :json
    assert_response :unprocessable_entity
  end
end
