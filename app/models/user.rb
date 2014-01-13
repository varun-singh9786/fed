class User < ActiveRecord::Base
  has_many :event_entries, dependent: :destroy
  has_many :food_entries, dependent: :destroy
  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, length: {minimum: 3}, uniqueness: {case_sensitive: false}
  before_create :create_remember_token



  def User.new_random_token
  	SecureRandom.urlsafe_base64
  end

  def User.encrypt(token) 
  	Digest::SHA1.hexdigest(token.to_s)
  end

private
  def create_remember_token
  	self.remember_token = User.encrypt(User.new_random_token)
  end
end
