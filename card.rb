class Card
  attr_reader :suit, :SUITS, :RANKS
  attr_accessor :price

  SUITS = ["\u2660", "\u2665", "\u2666", "\u2663"].freeze
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  def initialize(suit, price)
    @suit = suit
    @price = price
  end
end
