require './classes.rb'
system("clear")

puts 'Привет, это игра крестики-нолики'

# player1
print 'Введите имя первого игрока '
username = gets.chomp
player1 = Player.new(username)


# player2
print 'Введите имя второго игрока '
username = gets.chomp
player2 = Player.new(username)

game = Game.new(player1, player2)
# оперделение кто играет ноликами, а кто крестиками
system("clear")
puts "Теперь определимся, кто чем будет играть..."
puts "#{player1.username}, чем Вы хотите играть?"
puts "  1.Крестики"
puts "  2.Нолики"

amplua = nil
begin
    print "Введите цифру: "
    amplua = gets.chomp.to_i
end while (amplua != 1 && amplua != 2)

player1.initialize_amplua(amplua)
player2.initialize_amplua(0)
puts "OK!"

system("clear")
puts "Ознакомимся с игрорвым полем..."


game_desk = Desk.new

game_desk.greeting_desk
puts "Вот по этим номерам и будем выставлять крестики и нолики"
puts("Нажмите Enter")
gets


begin
  game_desk.display_desk
  puts("\n")
  game.make_a_move(game_desk)
end while (!game_desk.game_over?(player1) && !game_desk.game_over?(player2) && !game.game_over?)

# game_desk.display_desk