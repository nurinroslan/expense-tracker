class HomeController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in

  def index
    # Use the month parameter if provided; otherwise default to the current month.
    @month = params[:month].present? ? params[:month].to_i : Date.today.month

    # Load the month-specific budget from the monthly_budgets table.
    # This replaces the global user.monthly_budget to ensure each month has its own record.
    @monthly_budget = current_user.monthly_budgets.find_by(month: @month)&.amount || 0

    # Calculate total spending per category for the selected month.
    @categories_spent = calculate_categories_spent(@month) || {}

    # Define fixed colors for categories.
    @category_colors = get_category_colors

    # Calculate total spent amount for the selected month.
    @total_spent = @categories_spent.values.sum || 0

    # Retrieve expenses for the selected month.
    @expenses = Expense.where(user: current_user, date: Date.new(Date.today.year, @month, 1)..Date.new(Date.today.year, @month, -1))
  end

  private

  # Calculate total spending for each category in the selected month.
  def calculate_categories_spent(month)
    Expense.where(user: current_user)
           .where("extract(month from date) = ?", month)
           .group(:category)
           .sum(:price)
  rescue StandardError
    {}
  end

  # Define colors for expense categories.
  def get_category_colors
    {
      "Food" => "#FF6384",
      "Transportation" => "#36A2EB",
      "Entertainment" => "#FFCE56",
      "Utilities" => "#4BC0C0",
      "Other" => "#9966FF"
    }
  end
end
