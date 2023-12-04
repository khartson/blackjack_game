class Game < ApplicationRecord

  GAME_STATES = ['idle', 'user_turn', 'dealer_turn', 'bust', 'shuffle']
  # database relationship. Only databased info will be 
  # if game is active/outcome of the game. Everything else will be 
  # in memory (for now) 
  belongs_to :user

  # game has refernce to the deck used
  has_one :deck 

end
