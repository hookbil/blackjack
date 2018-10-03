class Card
  attr_reader :suit, :CARD_SYMBOLS, :RANKS
  attr_accessor :price

  CARD_SYMBOLS = ['♠', '♥', '♦', '♣'].freeze
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  def initialize(card_symbol, rank, price)
    @card_symbol = card_symbol
    @rank = rank
    validate!
    @suit = "#{rank}#{card_symbol}"
    @price = price
  end

  private

  def validate!
    raise 'Масть взята не из константы SUITS' unless CARD_SYMBOLS.include? @card_symbol
    raise 'Значение карты не из константы RANKS' unless RANKS.include? @rank
  end
end
