require_relative 'card'
require_relative 'deck'
require_relative 'dealer'
require_relative 'player'
# require_relative 'card'

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

  def game_field
    summary
    puts "Dealer cards count:#{@dealer.cards.size}, dealer sum:#{@dealer.sum}"
    puts "Player cards count:#{@player.cards.size}, player sum:#{@player.sum}"
  end

  def player_cards
    @player.show_cards
  end

  def game
    loop do
      return open_cards if cards_count
      game_field
      puts '1. Пропустить \n2. Добавить карты \n3. Открыть карты'
      answer = gets.chomp.to_i
      case answer
      when 1
        dealer_turn
      when 2
        add_card
      when 3
        open_cards
      when 4
        puts @dealer.show_cards
        puts @player.show_cards
      when 999
        exit
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
    summary
    winner
    if winner == 'Ничья'
      puts 'Ничья'
      retry_game
    end
    puts "Выиграл #{winner.name}"
    winner.bank += @bank
    @bank = 0
    retry_game
  end

  def retry_game
    puts 'Заново? yes/no'
    answer = gets.chomp.downcase
    start_game if answer == 'yes'
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

  def cards_count
    @player.cards.size == @dealer.cards.size && @dealer.cards.size == 3
  end

  private

  def start_cards
    while @dealer.cards.size < 2
      @deck.give_card(@player)
      @deck.give_card(@dealer)
    end
  end
end
