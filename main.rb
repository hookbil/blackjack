require_relative 'interface'

menu = Interface.new
puts 'Нажмите 1, чтобы начать игру'
puts 'Нажмите 999, чтобы завершить работу программы'
choice = gets.chomp.to_i
case choice
when 1
  menu.start_game(menu.player_name)
when 999
  return
end
