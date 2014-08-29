require_relative 'cell'
require 'pry'

class Minefield
  attr_reader :row_count, :column_count, :mine_count, :field

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @mine_count = mine_count
    @field = create_field(@row_count, @column_count)
  end

  def set_mines!(field)
    mine_count = @mine_count
    while mine_count > 0
      row = field.sample
      cell = row.sample
      if cell.mine[:exists] == false
        cell.set_mine
        mine_count -= 1
      end
    end
    field
  end

  def create_field(row_count, column_count)
    field = []
    (0..(row_count - 1)).each do |x|
        row = []
      (0..(column_count - 1)).each do |y|
        row << Cell.new(x,y)
      end
      field << row
    end
    set_mines!(field)
  end


  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    @field[row][col].cleared == true
  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    @field[row][col].clear

    if contains_mine?(row, col)
      @field[row][col].mine[:detonated].detonate
    else
      #clear and
      #check adjacent cells

    end
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    x = 0
    @field.each do |row|
      y = 0
      row.each do |col|
        if contains_mine?(x, y)
          if @field[x][y].mine[:detonated] == true
            return true
          end
        end
        y += 1
      end
      x += 1
    end
    false
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    x = 0
    @field.each do |row|
      y = 0
      row.each do |col|
        if contains_mine?(x, y)
          if @field[x][y].cleared == false
            return false
          end
        end
        y += 1
      end
      x += 1
    end
    true
  end


  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)
    #counter = 0
    #if contains_mine?(row - 1, col)
    #count += 1
    #etc
    0
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    @field[row][col].mine[:exists] == true
  end
end

test = Minefield.new(20, 20, 50)
binding.pry
