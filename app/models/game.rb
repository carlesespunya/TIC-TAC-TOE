class Game < ApplicationRecord
  has_many :bookings

  def won?(board)
    @wining = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]
    @wining.each do |combi|
      if board[combi[0]] == ""
        false
      else
        board[combi[0]] == board[combi[1]] && board[combi[1]] == board[combi[2]]
      end
    end
  end
end
