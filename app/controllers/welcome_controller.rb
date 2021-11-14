class WelcomeController < ApplicationController
  def index
    cookies[:name] = "Marco"
    @user_name = params[:name]
  end
end
