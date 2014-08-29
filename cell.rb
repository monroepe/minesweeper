class Cell
  attr_accessor :row, :col, :covered, :mine, :cleared

  def initialize(row, col)
    @row = row
    @col = col
    @mine = {exists: false, detonated: false}
    @cleared = false
  end

  def set_mine
    @mine[:exists] = true
  end

  def detonate
    @mine[:detonated] = true
  end

  def clear
    @cleared = true
  end
end
