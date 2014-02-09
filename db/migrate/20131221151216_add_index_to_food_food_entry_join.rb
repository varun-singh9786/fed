class AddIndexToFoodFoodEntryJoin < ActiveRecord::Migration
  def self.up
    add_index :foods_food_entries, :food_id
    add_index :foods_food_entries, :food_entry_id
  end
end
