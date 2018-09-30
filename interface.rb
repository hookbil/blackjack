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
    puts "Dealer sum:#{@game.status[:dealer_sum]}, dealer cards: #{@game.status[:dealer_cards]}"
    puts "Player sum:#{@game.status[:player_sum]}, player cards: #{@game.status[:player_cards]}"
    puts "Player balance: #{@game.status[:player_bank]}"
    puts "Dealer balance: #{@game.status[:dealer_bank]}"
  end

  def game_field
    @game.summary
    # puts "Dealer cards count:#{@game.status[:dealer_hand]}"
    puts "Player cards count:#{@game.status[:player_hand]}, player sum: #{@game.status[:player_sum]}, player cards: #{@game.status[:player_cards]}"
  end

  def player_turn
    return '2. Взять карту ' if @game.status[:player_turn]
  end

  def dealer_turn
    return '1. Пропустить ход' unless @game.status[:dealer_already_made_turn]
  end

  def open_cards
    winner
    endgame_field
    puts 'Заново? yes/no'
    answer = gets.chomp.downcase
    arr = %w[yes y]
    exit unless arr.include?(answer)
  end

  def winner
    winner = @game.status[:winner]
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
      return if @game.status[:time_to_open_cards]
      return if @game.status[:player_lost]
      return if @game.status[:dealer_lost]
      return if @game.status[:cards_count]
      puts "#{dealer_turn} #{player_turn} 3. Открыть карты"
      answer = gets.chomp.to_i
      return if answer == 3
      @game.turn(answer)
    end
  end
end

