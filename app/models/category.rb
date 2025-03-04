class Category < ApplicationRecord
  has_many :expenses
  has_many :category_budgets, dependent: :destroy

  # Returns the budget for the specified month (or 0.0 if none exists)
  def budget_for(month = Date.today.month)
    category_budgets.find_by(month: month)&.budget || 0.0
  end

  def total_spent
    expenses.sum(:amount)
  end

  def budget_status(month = Date.today.month)
    total_spent > budget_for(month) ? 'Exceeds Budget' : 'Within Budget'
  end
end
