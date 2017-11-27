class WelcomeController < ApplicationController
  include CreditCardService

  def index
    p "Hello"
    card = CreditCardService.new(params[:card_info])
  end
end
