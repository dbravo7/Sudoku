require "colorize"
require "byebug"
require_relative "./Board.rb"

class Game

    attr_reader :board, :coord, :value

    def initialize
        @board = Board.new
        @coord = 0
        @value = 0
        play
    end 

    def play
        unless @board.solved?
    
            @board.render  
            @coord = prompt_coord
                validate_coord?(@coord)
            @value = prompt_value
                validate_value?(@value)
            @board.place_tile(@coord, @value)
            play 
            # call @board method to place tile 

        end 
    end 

    def prompt_coord
        puts "Input the row and column of where you would like to place a number (e.g. 2,3)"
        get_input_coord
    end 

    def get_input_coord
        position = gets.chomp
        @coord = position.split(",").map do |ele|
            if !(/[a-zA-z]/.match?(ele))
                ele.to_i 
            end 
        end 
    end 

    def prompt_value
        puts "Input the value (1 - 9) that you would like there"
        get_input_value
    end 

    def get_input_value
        value = gets.chomp.to_i 
        value
    end 

    def validate_coord?(coord)
        if coord.length != 2 || invalid_integer?(coord) || @board.static_tile?(coord)
            puts "Please choose coordinates that are reflected on the board"
            sleep(2)
            validate_coord?(prompt_coord)
        end 
        @coord = coord 
        @coord 
    end 

    def invalid_integer?(coord)
        coord.each do |ele|
            if !ele.instance_of?(Integer) || ele > 8
                 return true 
            end 
        end 
        false 
    end 

    def validate_value?(value)
        if (value.to_s.length <=> 1) != 0 || value.class != Integer || value < 1
            puts "Please enter a value for the position that is a number between 1 to 9"
            sleep(2)
            validate_value?(prompt_value)
        end 
        @value = value 
        @value 
    end 

    # play loop  -- run till puzzle is solved 
        # update tile with new value 


end 

if $PROGRAM_NAME == __FILE__
        Game.new  
end 