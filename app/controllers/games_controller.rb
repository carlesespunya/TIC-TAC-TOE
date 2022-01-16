class GamesController < ApplicationController
  def index
    @games = Game.all.where(finished: false && bookings.lenght < 2)
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
    @player1 = @game.bookings[0].user
    @player2 = @game.bookings[1].user unless @game.bookings[1].nil?
    if @game.turn.even?
      @board[params[:index].to_i] = "X"
    else
      @board[params[:index].to_i] = "0"
    end
    if @game.won?(@board)
      @game.update(finished: true)
      if @game.turn.even?
        @player1.update(wins: @player1.wins += 1)
        @player2.update(losses: @player2.losses += 1)
      else
        @player2.update(wins: @player2.wins += 1)
        @player1.update(losses: @player1.losses += 1)
      end
    else
      turn = @game.turn + 1
      if turn > 8
        @player1.update(draws: @player1.draws += 1)
        @player2.update(draws: @player2.draws += 1)
        @game.update(finished: true)
      end
      @game.update(turn: turn, board: @board)
    end
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:title)
  end
end
