class User < ApplicationRecord
  has_many :posts
  has_many :comments

  has_many :activities

  def testing
    #card = CreditCardService.new(params[:card_info])
    #OrderSupport.total_shipping_charge(self)
  end
end
