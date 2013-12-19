class Food < ActiveRecord::Base
  has_one :food_entry
end
