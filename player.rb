require_relative 'dealer.rb'
class Player < Dealer
  attr_reader :name
  def initialize(name)
    @name = name
    super
  end
end
