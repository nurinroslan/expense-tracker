class RenamePriceToAmountInExpenses < ActiveRecord::Migration[7.0]
  def change
    rename_column :expenses, :price, :amount
  end
end
