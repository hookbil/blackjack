class Dealer
  attr_reader :name
  attr_accessor :sum, :cards, :bank
  def initialize(*name)
    @bank = 100
    @cards = []
    @sum = 0
    @name = name
  end

  def summary
    @sum = 0
    @cards.each do |card|
      if card.price.zero?
        card.price = @sum > 10 ? 1 : 11
      end
      @sum += card.price
    end
  end

  def show_cards
    hand = {}
    @cards.each { |card| hand[card.suit] = card.price }
    hand
  end
end
