require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(email: "user@example.com", password: "securepass")
    @category = Category.create!(name: "work", user: @user)
    @task = Task.create!(name: "hello", description: "world", due_date: Date.today, category: @category, completed: false)

    sign_in @user
  end
  test "should create a task" do
    post category_tasks_path(@category), params: {
      task: {
        name: "New Task",
        description: "Some description",
        due_date: Date.today,
        completed: false
      }
    }
    assert_response :redirect
  end

  test "should show task" do
    get category_task_path(@category, @task)
    assert_response :success
  end

  test "should get edit page" do
    get edit_category_task_path(@category, @task)
    assert_response :success
  end

  test "should update task" do
    patch category_task_path(@category, @task), params: {
      task: { name: "Updated Task Name" }
    }
    assert_response :redirect
  end

  test "should destroy task" do
    delete category_task_path(@category, @task)
    assert_response :redirect
  end
end
