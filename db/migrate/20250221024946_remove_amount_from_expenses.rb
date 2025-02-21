class RemoveAmountFromExpenses < ActiveRecord::Migration[8.0]
  def change
    remove_column :expenses, :amount, :decimal
  end
end
