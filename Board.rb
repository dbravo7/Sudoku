require "colorize"
require "byebug"
require 'set'
require_relative "./Tile.rb"

class Board

attr_reader :grid

    def initialize
        byebug
        @grid = Board.from_file("sudoku1.txt")
        @solution = Board.from_file("./puzzles/sudoku1_solved.txt")
        @static_tiles = Set.new([])
            store_static_tiles
            color_static_tiles
    end 

    def self.from_file(filename)
        grid = []
        File.open(filename).each_line do |line|
            grid << line.chomp("\n").split(//)
        end 
        grid 
    end 

    def color_static_tiles
        @grid.each_with_index do |subArr, row|
            @grid.each_with_index do |num , column|
                if @grid[row][column] != "0"
                    @grid[row][column].colorize(:red).bold 
                else
                    @grid[row][column].colorize(:blue) 
                end 
            end 
        end 
    end 

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
         row, col = pos
        @grid[row][col] = value
    end 
     
    def store_static_tiles
        @grid.each_with_index do |subArr, row|
            @grid.each_with_index do |num , column|
                if @grid[row][column] != "0"
                    @static_tiles << [row, column]
                end 
            end
        end 
        @static_tiles 
    end 

    def static_tile?(coord)
        @static_tiles.include?(coord)
    end 

   def render  
        num = @grid.length
        puts "  #{(0...num).to_a.join(' ')}".colorize(:cyan).underline
        @grid.each_with_index do |row, i|
            puts "#{i}".colorize(:cyan) + "|".colorize(:cyan) + "#{row.join(' ')}"
        end 
    end 

    # solved? to indicate the game is over 
    def solved? 
        @grid.each_with_index do |subArr, row|
            subArr.each_with_index do |ele, column|
                if @grid[row][column] == "0"
                    return false
                end 
            end 
        end 
        return true
    end 

    def place_tile(coord, value)
        byebug 
        self[coord] = value 
    end 


end 
# A method to update the value of a Tile at the given position 
# when a row is correct want the tiles to colorize and turn green, 
# otherwise should stay red until correct 
