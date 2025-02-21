class BudgetsController < ApplicationController
    before_action :authenticate_user!
  
    def update
      if current_user.update(monthly_budget: params[:monthly_budget])
        render json: { success: true, budget: current_user.monthly_budget }
      else
        render json: { success: false, error: "Failed to update budget" }, status: :unprocessable_entity
      end
    end
  end
  