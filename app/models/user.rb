class User < ActiveRecord::Base
  has_many :event_entries
  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, length: {minimum: 3}, uniqueness: {case_sensitive: false}
end
