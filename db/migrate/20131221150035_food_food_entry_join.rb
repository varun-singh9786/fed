class FoodFoodEntryJoin < ActiveRecord::Migration
  def self.up
    create_table 'foods_food_entries', id: false do |t|
      t.column 'food_id', :integer
      t.column 'food_entry_id', :integer
    end
  end
  
  def self.down
    drop_table 'foods_food_entries'
  end
end
