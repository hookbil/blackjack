require_relative 'player'
require_relative 'card'
class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def create_deck
    @cards.clear unless @cards.empty?
    suits = ["\u2660", "\u2665", "\u2666", "\u2663"]
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
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
    card = @cards.first
    @cards.delete(card)
    card
  end
end
