class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:edit, :update, :destroy]
  before_action :load_categories, only: [:new, :create, :edit, :update]

  def index
    @month = params[:month].present? ? params[:month].to_i : Date.today.month
    @selected_month = @month
    @expenses = current_user.expenses.includes(:category).where('MONTH(date) = ?', @month)
    @total_spent = @expenses.sum(:amount)
    @categories_spent = @expenses.group(:category_id).sum(:amount)
    
    # Load the budget for the selected month; if none exists, default to 0.
    @monthly_budget = current_user.monthly_budgets.find_by(month: @month)&.amount || 0
  
    @category_colors = {
      'Food' => '#FF4162',
      'Utilities' => '#17DEEE',
      'Transportation' => '#FF7F50',
      'Entertainment' => '#ECF284',
      'Other' => '#8A64D6'
    }.stringify_keys
  
    Category.pluck(:id, :name).each do |id, name|
      name = name.to_s
      @category_colors[name] ||= random_color
    end
  
    @categories_spent = @categories_spent.transform_keys { |id| Category.find_by(id: id)&.name || 'Unknown' }
  end

  def new
    selected_month = params[:month].present? ? params[:month].to_i : Date.today.month
    # Pre-populate with the 1st day of the selected month in the current year.
    @expense = current_user.expenses.build(date: Date.new(Date.today.year, selected_month, 1))
  end
  
  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path(month: @expense.date.month), notice: 'Expense was successfully created.'
    else
      flash.now[:alert] = 'Error creating expense. Please check your input.'
      @categories = Category.all
      render :new
    end
  end

  def edit; end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path(month: @expense.date.month), notice: 'Expense was successfully updated.'
    else
      flash.now[:alert] = 'Error updating expense. Please check your input.'
      @categories = Category.all  # Ensure categories are available in case of re-render
      render :edit
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_path(month: params[:month] || Date.today.month), notice: 'Expense was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def update_budget
    month = params[:month].to_i
    budget = current_user.monthly_budgets.find_or_initialize_by(month: month)
    budget.amount = params[:monthly_budget]
    if budget.save
      render json: { success: true, monthly_budget: budget.amount }
    else
      render json: { success: false, errors: budget.errors.full_messages }, status: :unprocessable_entity
    end
  end
   
  private

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, alert: 'Expense not found.'
  end  

  def load_categories
    @categories = Category.all
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :date, :category_id)
  end

  def random_color
    "##{('%06x' % rand(0..0xffffff))}"
  end
end
