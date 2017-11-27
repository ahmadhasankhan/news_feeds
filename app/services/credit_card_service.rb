class CreditCardService
  attr_reader :gateway, :credit_card

  def initialize(params)
    # Create a connection to ActiveMerchant
    @gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
        login: ENV["AUTHORIZE_LOGIN"],
        password: ENV["AUTHORIZE_PASSWORD"]
    )

    @credit_card = ActiveMerchant::Billing::CreditCard.new(
        number: params[:card_number],
        month: params[:card_expiration_month],
        year: params[:card_expiration_year],
        verification_value: params[:cvv],
        first_name: params[:card_first_name],
        last_name: params[:card_last_name],
        type: get_card_type(params[:card_number])
    )
  end


  private

  def get_card_type(number)
    length = number.size

    if length == 15 && number =~ /^(34|37)/
      'AMEX'
    elsif length == 16 && number =~ /^6011/
      'Discover'
    elsif length == 16 && number =~ /^5[1-5]/
      'MasterCard'
    elsif (length == 13 || length == 16) && number =~ /^4/
      'Visa'
    else
      'Unknown'
    end
  end
end
