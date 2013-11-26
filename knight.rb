class Knight < SteppingPiece

  DIFFS = [
    [-2, 1],
    [-2, -1],
    [2, 1],
    [2, -1],
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2]
  ]

  def to_s
    "N "
  end


end