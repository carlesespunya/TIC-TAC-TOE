class GamesController < ApplicationController
  def index
    @games = Game.all
    @booking = Booking.new
  end

  def show
    @game = Game.find(params[:id])
    @player1 = @game.bookings[0].user
    @player2 = @game.bookings[1].user unless @game.bookings[1].nil?
    @board = @game.board
    @user = current_user
  end

  def create
    @game = Game.new(game_params)
    @game.turn = 0
    @game.finished = false
    @game.save
    redirect_to games_path
  end

  def new
    @game = Game.new
  end

  def change_turn
    @game = Game.find(params[:id])
    @board = @game.board
    if @game.turn.even?
      @board[params[:index].to_i] = "X"
    else
      @board[params[:index].to_i] = "0"
    end
    if !won?(@board)
      @game.update(finished: true)
    else
      turn = @game.turn + 1
      @game.update(turn: turn, board: @board)
    end
    redirect_to game_path(@game)
  end

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

  private

  def game_params
    params.require(:game).permit(:title)
  end
end
