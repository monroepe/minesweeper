class Cell
  attr_accessor :row, :col, :covered, :mine, :cleared

  def initialize(row, col)
    @row = row
    @col = col
    @mine = {status: false, mine: nil}
    @cleared = false
  end

  def uncover
    @covered = false
  end

  def set_mine
    @mine[:status] = true
    @mine[:mine] = Mine.new
  end
end
