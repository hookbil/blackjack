require_relative 'game'
require_relative 'card'
require_relative 'deck'
require_relative 'dealer'
require_relative 'player'

class Interface
  def initialize(name)
    @game = Game.new(name)
  end

  def game_loop
    loop do
      new_game
      open_cards
    end
  end

  def endgame_field
    @game.summary
    puts "Dealer sum:#{@game.dealer_sum}, dealer cards: #{@game.dealer_cards}"
    puts "Player sum:#{@game.player_sum}, player cards: #{@game.player.show_cards}"
    puts "Player balance: #{@game.player_bank}"
    puts "Dealer balance: #{@game.dealer_bank}"
  end

  def game_field
    @game.summary
    puts "Player cards count:#{@game.player.cards.size}, player sum: #{@game.player_sum}, player cards: #{@game.player.show_cards}"
  end

  def dealer_turn
    return '1. Пропустить ход' unless @game.dealer_turn_count > 0
  end

  def open_cards
    winner
    endgame_field
    puts 'Заново? yes/no'
    answer = gets.chomp.strip.downcase
    arr = %w[yes y]
    exit unless arr.include?(answer)
  end

  def winner
    winner = @game.winner
    if winner == 'Ничья'
      @game.draw
      puts 'Ничья'
      return
    end
    puts "Выиграл #{winner.name}"
    @game.give_prize
  end

  def new_game
    @game.start_game
    loop do
      game_field
      return if @game.time_to_open_cards
      puts "#{dealer_turn} 2. Взять карту 3. Открыть карты"
      answer = gets.chomp.to_i
      return if answer == 3
      @game.turn(answer)
    end
  end
end
