class PagesController < ApplicationController

  skip_authorization_check

  def home
    @current_nav_identifier = :home
    @message = Message.new
  end

end
