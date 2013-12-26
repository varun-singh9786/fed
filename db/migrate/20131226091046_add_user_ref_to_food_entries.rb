class AddUserRefToFoodEntries < ActiveRecord::Migration
  def change
    add_reference :food_entries, :user, index: true
  end
end
