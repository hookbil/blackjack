class Game
  attr_accessor :bank
  attr_reader :player, :dealer
  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new('Dealer')
  end

  def start_game
    @bank = 0
    @deck = Deck.new
    @deck.create_deck
    stake
    start_cards
  end

  def dealer_turn
    return unless dealer_cards_count
    summary
    return if @dealer.sum >= 17
    @dealer.cards.push(give_card)
  end

  def add_card
    @player.cards.push(give_card) if player_cards_count
    dealer_turn
  end

  def check_cards
    return open_cards if cards_count
  end

  def player_cards_count
    @player.cards.size < 3
  end

  def dealer_cards_count
    @dealer.cards.size < 3
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
    a = @dealer.sum
    b = @player.sum
    return @player if a > 21
    return @dealer if b > 21
    return 'Ничья' if a == b
    return @player if b > a
    return @dealer if a > b
  end

  def give_money(name)
    prize(name)
    clear_cards
  end

  private

  def clear_cards
    @player.cards.clear
    @dealer.cards.clear
  end

  def stake
    @player.bank -= 10
    @dealer.bank -= 10
    @bank += 20
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
