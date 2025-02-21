class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all  # This fetches all expenses
  end
end
