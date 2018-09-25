class Game
  attr_accessor :bank
  attr_reader :player
  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new('Dealer')
    @deck = Deck.new
  end

  def start_game
    @end_game = 0
    @bank = 0
    @deck.create_deck
    clear_cards
    stake
    start_cards
  end

  def status
    {
      name: @player.name,
      bank: @bank,
      player_cards: player_cards,
      dealer_cards: dealer_cards,
      player_hand: player_hand,
      dealer_hand: dealer_hand,
      player_sum: player_sum,
      dealer_sum: dealer_sum,
      player_bank: player_bank,
      dealer_bank: dealer_bank
    }
  end

  def give_prize
    return if @end_game.zero?
    give_money(winner)
  end

  def turn(player_decision)
    dealer_turn if player_decision == 1
    add_card if player_decision == 2
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
    return 'Ещё не время' if @end_game == 0
    @dealer.show_cards
  end

  def dealer_can_take
    dealer_cards_count && @dealer.sum < 17
  end

  def summary
    @dealer.summary
    @player.summary
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

  def draw
    return if @end_game.zero?
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

  attr_reader :dealer

  def player_bank
    @player.bank
  end

  def dealer_bank
    @dealer.bank
  end

  def dealer_hand
    @dealer.cards.size
  end

  def player_hand
    @player.cards.size
  end

  def player_sum
    @player.sum
  end

  def dealer_sum
    @dealer.sum
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
