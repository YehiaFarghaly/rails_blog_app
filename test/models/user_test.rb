
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(name: "Test", email: "test@example.com", password: "password")
    assert user.valid?
  end

  test "invalid without name" do
    user = User.new(email: "test@example.com", password: "password")
    assert_not user.valid?
  end

  test "invalid without email" do
    user = User.new(name: "Test", password: "password")
    assert_not user.valid?
  end

  test "invalid without password" do
    user = User.new(name: "Test", email: "test@example.com")
    assert_not user.valid?
  end

  test "email uniqueness" do
    User.create!(name: "Test", email: "unique@example.com", password: "password")
    user2 = User.new(name: "Test2", email: "unique@example.com", password: "password")
    assert_not user2.valid?
  end
end
