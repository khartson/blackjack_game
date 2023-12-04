class Deck < ApplicationRecord
  HTTP_URL = "https://www.deckofcardsapi.com/api"

  # entity relationships
  belongs_to :game
  has_many :hands

  # before create, generate a shuffled deck
  before_create :build_deck 

  private

  # build deck
  # generates a shuffled deck from public deck 
  # of cards API, and adds the deck ID and url to the 
  # deck attr
  def build_deck
    response = build_serialized_json_response(HTTP_URL + "/deck/new/shuffle/?deck_count=1")
    deck_id = response['deck_id']
    remaining_cards = response['remaining']

    self.deck_url = HTTP_URL + "/deck/#{deck_id}"
    self.deck_id = deck_id
    self.remaining_cards = remaining_cards
  end 
  
end