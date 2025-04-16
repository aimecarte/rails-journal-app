class Task < ApplicationRecord
  belongs_to :category

  validates :due_date, comparison: { greater_than_or_equal_to: Date.today }
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5 }
end
