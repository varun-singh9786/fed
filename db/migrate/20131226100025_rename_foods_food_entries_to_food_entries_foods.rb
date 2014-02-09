class RenameFoodsFoodEntriesToFoodEntriesFoods < ActiveRecord::Migration
  def change
  	rename_table :foods_food_entries, :food_entries_foods
  end
end
