class Food < ActiveRecord::Base
  has_and_belongs_to_many :food_entries
end
