require_relative 'card'
require_relative 'deck'
require_relative 'dealer'
require_relative 'player'

class Menu
  def initialize
    @bank = 0
  end

  def start_game
    puts 'Введите имя: '
    name = gets.chomp.capitalize
    @player = Player.new(name)
    @dealer = Dealer.new('Dealer')
    @deck = Deck.new
    @deck.create_deck
    add_money
    start_cards
    game
  end

  def game
    loop do
      return open_cards if cards_count
      game_field
      puts '1. Пропустить \n2. Добавить карты \n3. Открыть карты'
      answer = gets.chomp.to_i
      case answer
      when 1
        dealer_turn if dealer_cards_count
      when 2
        add_card if player_cards_count
      when 3
        open_cards
      end
    end
  end

  def dealer_turn
    summary
    return if @dealer.sum >= 17
    @deck.give_card(@dealer)
  end

  def add_money
    @player.bank -= 10
    @dealer.bank -= 10
    @bank += 20
  end

  def summary
    @dealer.summary
    @player.summary
  end

  def add_card
    if @player.cards.size == 2
      @deck.give_card(@player)
    else
      dealer_turn
    end
  end

  def open_cards
    endgame_field
    winner
    if winner == 'Ничья'
      puts 'Ничья'
      retry_game
    end
    puts "Выиграл #{winner.name}"
    winner.bank += @bank
    @bank -= @bank
    retry_game
  end

  def retry_game
    puts 'Заново? yes/no'
    answer = gets.chomp.downcase
    arr = %w[yes y]
    exit unless arr.include?(answer)
    start_game if %w[yes y].include?(answer)
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

  private

  def start_cards
    while @dealer.cards.size < 2
      @deck.give_card(@player)
      @deck.give_card(@dealer)
    end
  end

  def player_cards_count
    @player.cards.size < 3 # == @dealer.cards.size && @dealer.cards.size == 3
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

  def game_field
    summary
    puts "Сумма ставки: #{@bank}"
    puts "Dealer cards count:#{@dealer.cards.size}"
    puts "Player cards count:#{@player.cards.size}, player sum:#{@player.sum}, player cards: #{player_cards}"
  end

  def endgame_field
    summary
    puts "Dealer sum:#{@dealer.sum}, dealer cards: #{dealer_cards}"
    puts "Player sum:#{@player.sum}, player cards: #{player_cards}"
  end
end
