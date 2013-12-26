class FoodEntry < ActiveRecord::Base
  has_and_belongs_to_many :foods
  belongs_to :user
end
