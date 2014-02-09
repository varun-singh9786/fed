class CreateFoodEntries < ActiveRecord::Migration
  def change
    create_table :food_entries do |t|
      t.integer :timestamp

      t.timestamps
    end
  end
end
