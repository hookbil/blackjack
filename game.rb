class Game
  attr_accessor :bank
  attr_reader :player, :dealer_turn_count
  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new('Dealer')
    @deck = Deck.new
  end

  def start_game
    @end_game = 0
    @dealer_turn_count = 0
    @bank = 0
    @deck.create_deck
    clear_cards
    stake
    start_cards
  end

  def status
    {
      dealer_cards: dealer_cards,
      player_sum: player_sum,
      dealer_sum: dealer_sum,
      player_bank: player_bank,
      dealer_bank: dealer_bank
    }
  end

  def turn(player_decision)
    dealer_turn if player_decision == 1
    add_card if player_decision == 2
  end

  def summary
    @dealer.summary
    @player.summary
  end

  def give_prize
    return if @end_game.zero?
    give_money(winner)
  end

  def draw
    return if @end_game.zero?
    @player.bank += 10
    @dealer.bank += 10
    @bank -= 20
  end

  def stake
    return unless @end_game.zero?
    @player.bank -= 10
    @dealer.bank -= 10
    @bank += 20
  end

  def winner
    summary
    @end_game = 1
    a = @dealer.sum
    b = @player.sum
    return 'Ничья' if a == b
    return 'Ничья' if a > 21 && b > 21
    return @player if a > 21
    return @dealer if b > 21
    return @player if b > a
    return @dealer if a > b
  end

  def time_to_open_cards
    return true if @dealer.sum > 21 || @player.sum > 21
    return true if @player.cards.size == 3 && @dealer.cards.size == 3
    return true if @player.cards.size == 3 && @dealer_turn_count > 0
  end

  private

  attr_reader :dealer

  def dealer_cards
    return 'Ещё не время' if @end_game.zero?
    @dealer.show_cards
  end

  def player_cards
    @player.show_cards
  end

  def player_cards_count
    @player.cards.size < 3
  end

  def dealer_cards_count
    @dealer.cards.size < 3
  end

  def player_turn
    player_cards_count
  end

  def player_bank
    @player.bank
  end

  def dealer_bank
    @dealer.bank
  end

  def player_sum
    @player.sum
  end

  def dealer_sum
    @dealer.sum
  end

  def dealer_turn
    summary
    @dealer_turn_count += 1
    return unless dealer_cards_count
    return if @dealer.sum >= 17
    @dealer.cards.push(give_card)
  end

  def add_card
    @player.cards.push(give_card) if player_cards_count
    summary
    dealer_turn
  end

  def give_money(player)
    player.bank += @bank
    @bank -= @bank
  end

  def clear_cards
    @player.cards.clear
    @dealer.cards.clear
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
