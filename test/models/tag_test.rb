
require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "valid tag" do
    tag = Tag.new(name: "Ruby")
    assert tag.valid?
  end

  test "invalid without name" do
    tag = Tag.new
    assert_not tag.valid?
  end

  test "name uniqueness" do
    Tag.create!(name: "Unique")
    tag2 = Tag.new(name: "Unique")
    assert_not tag2.valid?
  end
end
