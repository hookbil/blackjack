require_relative 'interface'

puts 'Введите имя: '
name = gets.chomp.capitalize
menu = Interface.new(name)
puts 'Начать игру? 1. Начать 999. Выход'
choice = gets.chomp.to_i
case choice
when 1
  menu.new_game
when 999
  return
end
