require_relative 'card'
class Deck
  attr_reader :hash

  def initialize
    @hash = {}
  end

  def create_deck
    card_symbols = Card.new
    suits = [card_symbols.spade, card_symbols.heart, card_symbols.diamond, card_symbols.club]
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
    suits.each do |suit|
      ranks.each do |rank|
        card = "#{rank}#{suit}"
        @hash.store(card, rank) if rank.is_a? Integer
        @hash.store(card, 0) if rank == 'A'
        @hash.store(card, 10) if %w[J Q K].include? rank
      end
    end
    @hash = @hash.to_a.shuffle.to_h
  end

  def give_card
  end
end

deck = Deck.new
deck.create_deck
puts deck.hash
puts deck.hash.size
