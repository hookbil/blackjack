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
      if card.price.zero?
        if @sum > 10
          card.price = 1
        else
          card.price = 11
        end
        @sum += card.price
      end
    end
  end

  def show_cards
    @cards.each { |card| print "#{card.suit}, #{card.price}" }
  end
end
