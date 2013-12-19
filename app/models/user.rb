class User < ActiveRecord::Base
  has_many :food_entries
  has_many :event_entries
end
