class King < SteppingPiece

  DIFFS = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, 1],
    [0, -1],
    [1, -1],
    [1, 0],
    [1, -1]
  ]

  def to_s
    "K "
  end
end