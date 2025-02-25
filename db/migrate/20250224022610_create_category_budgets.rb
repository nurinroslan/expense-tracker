class CreateCategoryBudgets < ActiveRecord::Migration[8.0]
  def change
    create_table :category_budgets do |t|
      t.references :category, null: false, foreign_key: true
      t.integer :month
      t.decimal :budget

      t.timestamps
    end
  end
end
