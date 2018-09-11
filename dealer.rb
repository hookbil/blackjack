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
    @cards.each { |card| @sum += card.price }
    @cards.each do |card|
      next unless card.price.zero?
      card.price = if @sum > 10
                     1
                   else
                     11
                   end
      @sum += card.price
    end
  end

  def show_cards
    hand = {}
    @cards.each { |card| hand[card.suit] = card.price } # "#{card.suit}, #{card.price}" }
    hand
  end
end
