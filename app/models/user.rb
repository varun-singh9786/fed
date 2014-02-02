class User < ActiveRecord::Base
  has_many :event_entries, dependent: :destroy
  has_many :food_entries, dependent: :destroy
  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, length: {minimum: 3}, uniqueness: {case_sensitive: false}



  def to_hash(remember_token)
    {id: self.id, name: self.name, email: self.email, remember_token: remember_token}
  end


  def User.new_random_token
  	SecureRandom.urlsafe_base64
  end

  def User.encrypt(token) 
  	Digest::SHA1.hexdigest(token.to_s)
  end

end
