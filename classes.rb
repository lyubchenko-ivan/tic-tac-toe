# класс описывающий игровую поверхность
class Desk
    attr_reader :cols, :rows
    attr_accessor :desk

    def initialize
        @cols = 3
        @rows = 3
        @desk =  [
            ['-', '-', '-'],
            ['-', '-', '-'],
            ['-', '-', '-']
        ]
    end
    
    
    def greeting_desk
        self.rows.times do |row|

            self.cols.times do |column|
                print "  #{row * 3 + column + 1}"
                print "|" if column != 2
            end
            puts
            if (row != 2)
                self.cols.times do |column|
                    print "---"
                    print '+' if (column != 2)
                end
                puts
            end

        end
    end

    def position_empty?(number)
        row = (number - 1)  / 3
        column = (number - 1) % 3
        if (self.desk[row][column] == '-') then return  true
        else return false
        end
    end

    def display_desk
        system("clear")
        self.rows.times do |row|
            self.cols.times do |column|
                print " #{self.desk[row][column]} "
                print "|" if column != 2
            end
            puts

            if (row != 2)
                self.cols.times do |column|
                    print "---"
                    print '+' if column != 2
                end
                puts
            end


        end
    end

    def take_sym(sym, index)
        row = (index - 1) / 3
        col = (index - 1) % 3
        self.desk[row][col] = sym
    end

    def game_over?(player)
        #три по горизонтали
        self.desk.each  do |row|
             if (row.all? {|el| el == player.amplua})
                puts "Победил игрок #{player.username}. Игра окончена."
                return  true
            end
        end

        #три по вертикали
        self.cols.times do |column|
            status = true
            self.rows.times do |row|
                if (!(self.desk[row][column] == self.desk[0][column] && self.desk[row][column] == player.amplua) )
                    status = false
                end
            end

            if (status)
                puts "Победил игрок #{player.username}. Игра окончена."
                return true
            end
        end

        #три по  главной диагонали
        status = true
        self.rows.times do |index|
            if !(self.desk[index][index] == self.desk[0][0] && player.amplua == self.desk[0][0]) then status = false end

        end
        if status == true
            puts "Победил игрок #{player.username}. Игра окончена."
            return  true
        end

        #три по побочной диагонали
        status = true
        self.rows.times do |index|
            if (self.desk[index][self.desk.length - 1 - index] != self.desk[0][self.desk.length - 1] || self.desk[0][self.desk.length - 1] != player.amplua)
                status = false
            end
        end
        if status == true
            puts "Победил игрок #{player.username}. Игра окончена."
            return  true
        end

        return  false


    end
end



# клас описывающий игрока
class Player
    @@count_players = 1
    @@broned = nil
    attr_reader :username, :id, :amplua, :game_desk

    def initialize(username = "player#{@@count_players}")
        if (username == ' ') then username = "player#{@@count_players}" end
        @username = username
        @id = @@count_players
        @@count_players += 1
    end

    def initialize_amplua(amplua)
        if (self.id == 1)
            if (amplua == 1)
                @amplua = 'X'
            else 
                @amplua = 'O'
            end    
            @@bronned = @amplua
        elsif(self.id == 2)
            if (@@bronned == 'X')
                @amplua = 'O'
            else @amplua = 'X'
            end    
        end    
    end



    def makeAMove(desk)
        @game_desk = desk
        index = nil
        begin
            puts "#{self.username}, в какую ячейку Вы хотите поставить \"#{self.amplua}\""
            index = gets.chomp.to_i
        end while(!(index >= 1 && index <= 9) || !(self.game_desk.position_empty?(index)))

        self.game_desk.take_sym(self.amplua, index)
    end
end


class Game
    @@moves = 0
    attr_reader :player1, :player2
    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
    end

    def game_over?
        return  true  if (@@moves >= 9)
        return  false
    end

    def make_a_move(desk)
        @game_desk = desk
        @@moves += 1

        if (@@moves % 2 == 0)
            #make move a player2
            self.player2.makeAMove(desk)
        else
            #make move a player1
            self.player1.makeAMove(desk)
        end

    end

    def game_over?
        if (@@moves == 9)
            system("clear")
            puts("Ничья. Спасибо за игру")
            return true
        end
    end
end