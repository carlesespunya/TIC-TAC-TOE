class Game < ApplicationRecord
  has_many :bookings

  def won?(board)
    @wining = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]
    @result = 0
    @wining.each do |combi|
      index1 = combi[0]
      index2 = combi[1]
      index3 = combi[2]
      position1 = board[index1]
      position2 = board[index2]
      position3 = board[index3]
      @result += 1 if position1 == position2 && position2 == position3 && position1 != ""
    end
    return @result > 0
  end
end
