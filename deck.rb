require_relative 'player'
require_relative 'card'
class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def create_deck
    card_symbols = Card::CARD_SYMBOLS
    ranks = Card::RANKS
    @cards.clear unless @cards.empty?
    card_symbols.each do |card_symbol|
      ranks.each do |rank|
        if rank.is_a? Integer
          price = rank
        elsif rank == 'A'
          price = 0
        else
          price = 10
        end
        card = Card.new(card_symbol, rank, price)
        @cards.push(card)
      end
    end
    @cards.shuffle!
  end

  def give_card
    @cards.pop
  end
end
