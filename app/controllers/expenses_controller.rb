class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:destroy]
  before_action :load_categories, only: [:new, :create, :edit, :update]

  def index
    @month = params[:month].present? ? params[:month].to_i : Date.today.month
    @selected_month = @month
    @expenses = current_user.expenses.includes(:category).where('MONTH(date) = ?', @month)

    @total_spent = @expenses.sum(:price)
    @categories_spent = @expenses.group(:category_id).sum(:price)

    @category_colors = {
      'Food' => '#FF4162', 'Utilities' => '#17DEEE',
      'Transportation' => '#FF7F50', 'Entertainment' => '#ECF284',
      'Other' => '#8A64D6'
    }

    Category.pluck(:id, :name).each do |id, name|
      @category_colors[name] ||= random_color
    end

    @categories_spent = @categories_spent.transform_keys { |id| Category.find_by(id: id)&.name || 'Unknown' }
  end

  def new
    @expense = current_user.expenses.build
  end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: 'Expense was successfully created.'
    else
      flash.now[:alert] = 'Error creating expense. Please check your input.'
      @categories = Category.all  # Ensure categories are available in case of re-render
      render :new
    end
  end

  def edit; end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: 'Expense was successfully updated.'
    else
      flash.now[:alert] = 'Error updating expense. Please check your input.'
      @categories = Category.all  # Ensure categories are available in case of re-render
      render :edit
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_path, notice: 'Expense was successfully deleted.' }
      format.json { head :no_content }
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
    params.require(:expense).permit(:name, :price, :date, :category_id)
  end

  def random_color
    "##{('%06x' % rand(0..0xffffff))}"
  end
end
