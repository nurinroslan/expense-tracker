class ChangeAmountPrecisionInExpenses < ActiveRecord::Migration[8.0]
  def change
    change_column :expenses, :amount, :decimal, precision: 10, scale: 2
  end
end
