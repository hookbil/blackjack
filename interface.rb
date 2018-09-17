require_relative 'game'
require_relative 'card'
require_relative 'deck'
require_relative 'dealer'
require_relative 'player'

class Interface
  def initialize(name)
    @game = Game.new(name)
  end

  #def start_game
  #  new_game(@game)
  #end

  def player_name
    puts 'Введите имя: '
    @name = gets.chomp.capitalize
  end

  def endgame_field
    @game.summary
    puts "Dealer sum:#{@game.dealer.sum}, dealer cards: #{@game.dealer_cards}"
    puts "Player sum:#{@game.player.sum}, player cards: #{@game.player_cards}"
    puts "Player balance: #{@game.player.bank}"
    puts "Dealer balance: #{@game.dealer.bank}"
  end

  def game_field
    @game.summary
    puts "Сумма ставки: #{@game.bank}"
    puts "Dealer cards count:#{@game.dealer.cards.size}"
    puts "Player cards count:#{@game.player.cards.size}, player sum:#{@game.player.sum}, player cards: #{@game.player_cards}"
  end

  def open_cards
    winner
    endgame_field
  end

  def winner
    winner = @game.winner
    if winner == 'Ничья'
      @game.draw
      puts 'Ничья'
      return
    end
    puts "Выиграл #{winner.name}"
    @game.give_money(winner)
  end

  def retry_game
    puts 'Заново? yes/no'
    answer = gets.chomp.downcase
    arr = %w[yes y]
    new_game if arr.include?(answer)
  end

  def new_game
    @game.start_game
    game_field
    puts '1. Пропустить ход 2. Взять карту 3. Открыть карты'
    answer = gets.chomp.to_i
    case answer
    when 1
      @game.dealer_turn
    when 2
      @game.add_card
    when 3
      open_cards
    end
  end
end
