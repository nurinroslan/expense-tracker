class CategoryBudgetsController < ApplicationController
    before_action :set_category
  
    def new
      selected_month = params[:month].present? ? params[:month].to_i : Date.today.month
      @category_budget = @category.category_budgets.find_or_initialize_by(month: selected_month)
    end
  
    def create
      selected_month = category_budget_params[:month].to_i
      @category_budget = @category.category_budgets.find_or_initialize_by(month: selected_month)
  
      if @category_budget.update(category_budget_params)
        redirect_to category_path(@category), notice: "Budget saved successfully for month #{selected_month}."
      else
        render :new
      end
    end
  
    def edit
      @category_budget = @category.category_budgets.find_or_initialize_by(month: params[:month].to_i)
    end
  
    def update
      selected_month = category_budget_params[:month].to_i
      @category_budget = @category.category_budgets.find_or_initialize_by(month: selected_month)
  
      if @category_budget.update(category_budget_params)
        redirect_to category_path(@category), notice: "Budget updated successfully for month #{selected_month}."
      else
        render :edit
      end
    end
  
    private
  
    def set_category
      @category = Category.find(params[:category_id])
    end
  
    def category_budget_params
      params.require(:category_budget).permit(:budget, :month)
    end
  end
  