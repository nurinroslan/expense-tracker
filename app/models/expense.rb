class Expense < ApplicationRecord
  belongs_to :category  # Ensure Expense belongs to Category
  belongs_to :user

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true
  validates :date, presence: true
end