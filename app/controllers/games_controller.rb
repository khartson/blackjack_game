class GamesController < ApplicationController


  def create
    session[:deck] = create_deck
    session[:player_hand] = []
    session[:dealer_hand] = []
    deal
  end 

  def index
    if session[:deck]
      return render_cards
    else 
      render json: { errors: ["No active game"] }
    end 
  end 

  def hit
    session[:player_hand] << session[:deck].pop
    render json: check_bust(session[:player_hand])
  end 


  private
  
  def deal 
    2.times do | x | session[:player_hand] << session[:deck].pop end 
    2.times do | x | session[:dealer_hand] << session[:deck].pop end
    return render_cards
  end 



  def render_cards
    return render json: { dealer: session[:dealer_hand], player: session[:player_hand] } 
  end 

  def create_deck
    suits = ['clubs', 'spades', 'hearts', 'diamonds']
    faces  = [*(2..10), 'jack', 'queen', 'king', 'ace']
    cards = []
    faces.each do | face |
      if face.class == Integer
        value = face 
      elsif face == "ace"
        value = 1 
      else 
        value = 10
      end 
      suits.each do | suit | 
        cards << { face: face, suit: suit, value: value }
      end 
    end 
    return cards.shuffle
  end 

  def check_bust(hand)
    total = hand.sum{ | card | card["value"] }
    if total > 21 
      return { res: 'bust', tot: total }
    elsif total == 21
      return { res: 'blackjack', tot: total }
    else 
      return { res: "continue", tot: total }
    end 
  end 

end
