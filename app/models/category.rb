class Category < ApplicationRecord
    has_many :expenses
  
    def total_spent
      expenses.sum(:price)
    end
  
    def budget_status
      total_spent > budget ? 'Exceeds Budget' : 'Within Budget'
    end
  end
  