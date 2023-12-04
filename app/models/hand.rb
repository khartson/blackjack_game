class Hand < ApplicationRecord
  belongs_to :deck
  has_many :cards

  # populate hand from the deck id
  before_create :generate_pile_url 

  # add a number of cards to the hand
  # must make a first request to draw from the deck
  # then add those cards to the current hand
  def add_cards(amount)
    response = build_serialized_json_response(self.deck.deck_url + "/draw/?count=#{amount}")
    self.deck.remaining_cards = response["remaining"]
    codes = []
    response["cards"].each do | card | 
      codes.push(card["code"]) 
    end 
    # add new cards to the current hand
    build_serialized_json_response(self.pile_url + "/add/?cards=#{codes.join(",")}")
  end
  
  def list_cards_in_hand
    response = build_serialized_json_response(self.pile_url + "/list")
  end 
  
  private

  # creates the hand (a pile) and generates API link 
  def generate_pile_url
    self.pile_url =  self.deck.deck_url + "/pile/#{self.hand_type}"
    response = build_serialized_json_response(self.pile_url + "/add/?cards=")
  end 

end
