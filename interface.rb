require_relative 'game'
require_relative 'card'
require_relative 'deck'
require_relative 'dealer'
require_relative 'player'

class Interface
  def start_game(name)
    @game = Game.new(name)
    game(@game)
  end

  def player_name
    puts 'Введите имя: '
    @name = gets.chomp.capitalize
  end

  def endgame_field
    puts "Dealer sum:#{@game.dealer.sum}, dealer cards: #{@game.dealer_cards}"
    puts "Player sum:#{@game.player.sum}, player cards: #{@game.player_cards}"
  end

  def game_field
    puts "Сумма ставки: #{@game.bank}"
    puts "Dealer cards count:#{@game.dealer.cards.size}, dealer cards: #{@game.dealer_cards}"
    puts "Player cards count:#{@game.player.cards.size}, player sum:#{@game.player.sum}, player cards: #{@game.player_cards}"
  end

  def open_cards
    endgame_field
    winner
  end

  def winner
    winner = @game.winner
    return puts 'Ничья' if winner == 'Ничья'
    puts "Выиграл #{winner.name}"
    @game.give_money(winner)
  end

  def retry_game
    puts 'Заново? yes/no'
    answer = gets.chomp.downcase
    arr = %w[yes y]
    exit unless arr.include?(answer)
    start_game(@name)
  end

  def game(*)
    @game.start_game
    @game.check_cards
    loop do
      @game.summary
      game_field
      puts '1. Пропустить \n2. Добавить карты \n3. Открыть карты'
      answer = gets.chomp.to_i
      case answer
      when 1
        @game.dealer_turn
      when 2
        @game.add_card
      when 3
        open_cards
        retry_game
      end
    end
  end
end
