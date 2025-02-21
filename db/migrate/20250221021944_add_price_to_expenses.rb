class AddPriceToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :price, :decimal
  end
end
