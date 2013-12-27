class Food < ActiveRecord::Base
  has_and_belongs_to_many :food_entries
  validates :food_name, presence: true, length: {minimum: 2}
  validates :cooked_description, presence: true, length: {minimum: 2}
end
