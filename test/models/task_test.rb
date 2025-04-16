require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "user@example.com", password: "securepass")
    @category = Category.create!(name: "work", user: @user)
  end

  test "valid task saves successfully" do
    task = Task.new(
      name: "Test Task",
      description: "Valid description",
      due_date: Date.today,
      category: @category
    )
    assert task.save
  end

  test "task without name does not save" do
    task = Task.new(
      name: "",
      description: "Valid description",
      due_date: Date.today,
      category: @category
    )
    assert_not task.save
  end

  test "task with short description does not save" do
    task = Task.new(
      name: "Test Task",
      description: "1234",
      due_date: Date.today,
      category: @category
    )
    assert_not task.save
  end

  test "task with past due_date does not save" do
    task = Task.new(
      name: "Test Task",
      description: "Valid description",
      due_date: Date.yesterday,
      category: @category
    )
    assert_not task.save
  end
end
