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
    puts "Dealer sum:#{@game.dealer.sum}, dealer cards: #{@game.dealer_cards}"
    puts "Player sum:#{@game.player.sum}, player cards: #{@game.player_cards}"
    puts "Player balance: #{@game.player.bank}"
    puts "Dealer balance: #{@game.dealer.bank}"
  end

  def game_field
    @game.summary
    puts "Dealer cards count:#{@game.dealer.cards.size}"
    puts "Player cards count:#{@game.player.cards.size}, player sum:#{@game.player.sum}, player cards: #{@game.player_cards}"
  end

  def player_turn
    return '2. Взять карту ' if @game.player_cards_count
  end

  def dealer_turn
    return '1. Пропустить ход' if @game.dealer_can_take
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
      return if @game.player_lost
      return if @game.dealer_lost
      return if @game.cards_count
      puts "#{dealer_turn} #{player_turn} 3. Открыть карты"
      answer = gets.chomp.to_i
      case answer
      when 1
        @game.dealer_turn
      when 2
        @game.add_card
      when 3
        return
      end
    end
  end
end
