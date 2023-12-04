class GamesController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  # create a new game
  # add user from session
  # create an active game in session
  # create hands for the player and dealer
  # this will need refactored eventually as it generates
  # a lot of sql - was in a time cruncn. Will also work 
  # to move storage out of session hash
  def create
    # create game and store id
    # store as active game in session
    game = Game.create!(user_id: session[:user_id], state: 'idle')
    game_id = game.id
    session[:active_game_id] = game_id
    # create the deck and store it in session
    deck = Deck.create!(game_id: game_id)
    deck_id = deck.id
    session[:deck_id] = deck.deck_id

    player_hand = Hand.create!(hand_type: 'player', deck_id: deck_id)
    session[:player_hand] = player_hand
    dealer_hand = Hand.create!(hand_type: 'dealer', deck_id: deck_id)
    session[:dealer_hand] = dealer_hand
    render json: game, status: :created
  end 

  # deal cards at start of new hand
  def deal
    game = get_active_game
    if game&.state == 'idle'
      game.state = 'user_turn'
      card_response = []
      game.deck.hands.each do | hand |
        hand.add_cards(2)
      end 
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end 
  end 

  # for when player and dealer hit
  def hit
  end 

  # end game and destroy active session
  # should create validation to make any game with 'complete' 
  # status field read-only 
  def destroy 
    game = get_active_game
    game.status = 'complete'
  end 

   

  private
  
  def get_active_game
    active_game = Game.find_by(id: session[:active_game_id])
  end 

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end 
end
