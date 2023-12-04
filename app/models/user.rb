class User < ApplicationRecord
  has_secure_password
  
  # user will have many games through fk on 
  # games table and indexed on user id
  # for faster lookup. 
  has_many :games

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
