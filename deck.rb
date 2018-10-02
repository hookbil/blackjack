require_relative 'player'
require_relative 'card'
class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def create_deck
    suits = Card::SUITS
    ranks = Card::RANKS
    @cards.clear unless @cards.empty?
    suits.each do |suit|
      ranks.each do |rank|
        card_suit = "#{rank}#{suit}"
        if rank.is_a? Integer
          price = rank
        elsif rank == 'A'
          price = 0
        else
          price = 10
        end
        card = Card.new(card_suit, price)
        @cards.push(card)
      end
    end
    @cards.shuffle!
  end

  def give_card
    card = @cards.pop
    card
  end
end
