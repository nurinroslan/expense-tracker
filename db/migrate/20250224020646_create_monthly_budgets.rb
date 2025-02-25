class CreateMonthlyBudgets < ActiveRecord::Migration[8.0]
  def change
    create_table :monthly_budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :month, null: false
      t.decimal :amount, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end

    add_index :monthly_budgets, [:user_id, :month], unique: true
  end
end
