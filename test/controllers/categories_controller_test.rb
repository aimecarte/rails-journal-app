require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(email: "user@example.com", password: "securepass")
    @category = Category.create!(name: "work", user: @user)

    sign_in @user
  end
  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  test "should show category" do
    get category_path(@category)
    assert_response :success
  end

  test "should get edit page" do
    get edit_category_path(@category)
    assert_response :success
  end

  test "should create a category" do
    post categories_path, params: { category: { name: "Test Category" } }
    assert_response :redirect
  end

  test "should update a category" do
    patch category_path(@category), params: { category: { name: "Updated Name" } }
    assert_response :redirect
  end

  test "should destroy a category" do
    delete category_path(@category)
    assert_response :redirect
  end
end
