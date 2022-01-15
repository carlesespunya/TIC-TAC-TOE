class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @signed_in = user_signed_in?
    @current_user = current_user
  end

end
