class Card
  attr_reader :suit
  attr_accessor :price
  def initialize(suit, price)
    @suit = suit
    @price = price
  end
end
