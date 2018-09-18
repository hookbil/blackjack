class Game
  attr_accessor :bank
  attr_reader :player, :dealer
  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new('Dealer')
    @deck = Deck.new
  end

  def start_game
    @bank = 0
    @deck.create_deck
    clear_cards
    stake
    start_cards
    puts @deck.cards.size
  end

  def dealer_turn
    summary
    return unless dealer_cards_count
    return if @dealer.sum >= 17
    @dealer.cards.push(give_card)
  end

  def add_card
    @player.cards.push(give_card) if player_cards_count
    summary
    dealer_turn
  end

  def player_cards_count
    @player.cards.size < 3
  end

  def dealer_cards_count
    @dealer.cards.size < 3
  end

  def player_lost
    @player.sum > 21
  end

  def dealer_lost
    @dealer.sum > 21
  end

  def cards_count
    @player.cards.size == 3 && @dealer.cards.size == 3
  end

  def player_cards
    @player.show_cards
  end

  def dealer_cards
    @dealer.show_cards
  end

  def summary
    @dealer.summary
    @player.summary
  end

  def winner
    summary
    a = @dealer.sum
    b = @player.sum
    return 'Ничья' if a == b
    return 'Ничья' if a > 21 && b > 21
    return @player if a > 21
    return @dealer if b > 21
    return @player if b > a
    return @dealer if a > b
  end

  def give_money(player)
    player.bank += @bank
    @bank -= @bank
  end

  def draw
    @player.bank += 10
    @dealer.bank += 10
    @bank -= 20
  end

  def stake
    @player.bank -= 10
    @dealer.bank -= 10
    @bank += 20
  end

  private

  def clear_cards
    @player.cards.clear
    @dealer.cards.clear
  end

  def prize(player)
    player.bank += @bank
    @bank -= @bank
  end

  def start_cards
    while @dealer.cards.size < 2
      card = @deck.give_card
      @player.cards.push(card)
      card = @deck.give_card
      @dealer.cards.push(card)
    end
  end

  def give_card
    @deck.give_card
  end
end
