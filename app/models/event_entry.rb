class EventEntry < ActiveRecord::Base
  belongs_to :user
  validates :event_description, presence: true, length: {minimum: 2}
  validates :event_timestamp, presence: true
  validates :event_rating, presence: true
end
