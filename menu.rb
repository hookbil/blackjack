require_relative 'card'
require_relative 'deck'
require_relative 'dealer'
require_relative 'player'
# require_relative 'card'


class Menu # возможно стоит переименовать в game
  def initialize
    

  end

end


deck = Deck.new
deck.create_deck
card_deck = deck.hash
card_deck = deck.hash.to_a.shuffle.to_h

puts card_deck