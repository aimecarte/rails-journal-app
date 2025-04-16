require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "user@example.com", password: "securepass")
  end

  test "valid category saves successfully" do
    category = Category.new(name: "Work", user: @user)
    assert category.save
  end

  test "category without name does not save" do
    category = Category.new(name: "", user: @user)
    assert_not category.save
  end
end
