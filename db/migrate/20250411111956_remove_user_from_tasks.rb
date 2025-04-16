class RemoveUserFromTasks < ActiveRecord::Migration[7.2]
  def change
    remove_reference :tasks, :user, null: false, foreign_key: true
  end
end
