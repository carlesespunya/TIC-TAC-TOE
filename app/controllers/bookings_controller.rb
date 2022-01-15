class BookingsController < ApplicationController
  def create
    @game = Game.find(params[:booking][:game_id])
    @user = current_user
    found = false
    if @game.bookings
      @game.bookings.each do |booking|
        found = true if booking.user_id == @user.id
      end
    end
    if found
      redirect_to game_path(@game)
    elsif @game.bookings.length < 2
      @booking = Booking.new(game: @game, user: @user)
      if @booking.save
        redirect_to game_path(@game)
      else
        # raise
        @games = Game.all
        render "games/index"
      end
    else
      flash[:alert] = "Game is full"
      redirect_to games_path
    end
  end
end
