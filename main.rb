require_relative 'interface'

puts 'Введите имя: '
name = gets.chomp.capitalize
menu = Interface.new(name)
puts 'Начать игру? 1. Начать 999. Выход'
choice = gets.chomp.to_i

case choice
when 1
  menu.game_loop
when 999
  exit
end
