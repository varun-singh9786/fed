class FoodEntry < ActiveRecord::Base
  has_and_belongs_to_many :foods
  belongs_to :user

  validates :timestamp, presence: true

  def to_hash
  	hash = self.attributes
  	hash[:foods] = self.foods
  	hash
  end
end
