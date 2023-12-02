class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true

  # After object instantiation but before 
  # database creation, add 10 credits to 
  # the user account 
  before_create :add_credits
  
  private
  
  # add_credits
  def add_credits
    self.credits = 10
  end 
end
