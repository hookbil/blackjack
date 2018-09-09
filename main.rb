require_relative 'card'
require_relative 'deck'
require_relative 'dealer'
require_relative 'player'
require_relative 'menu'
menu = Menu.new
puts "Нажмите 1, чтобы начать игру"
puts "Нажмите 999, чтобы завершить работу программы"
choice = gets.chomp.to_i
case choice
when 1
  menu.start_game
when 999
  return

end