require_relative 'card'
class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def create_deck
    card_symbols = Card.new
    suits = [card_symbols.spade, card_symbols.heart, card_symbols.diamond, card_symbols.club]
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
    suits.each do |suit|
      ranks.each do |rank|
        card = "#{rank}#{suit}"
        @cards.push(card)
      end
    end
  end
end
