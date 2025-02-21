class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.decimal :budget, default: 0.0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
