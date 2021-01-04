# класс описывающий игровую поверхность
class Desk
    attr_reader :cols, :rows
    def initialize
        @cols = 3
        @rows = 3
    end    

    def display
        system("clear")
        self.rows.times do
            
            self.cols.times do
                print"1 |"
            end
            puts
            # self.cols.times do
            #     print"   "
            # end
            # puts

            self.cols.times do
                print "--+"
            end
            puts
        end
    end    
end

# клас описывающий игрока
class Player

end    

# класс описвающий процесс игры
class Game 

end    

# класс описывающий ячейку
class Cell

end    