class CreateFoodEntries < ActiveRecord::Migration
  def change
    create_table :food_entries do |t|
      t.integer :food_timestamp
      t.references :food, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
