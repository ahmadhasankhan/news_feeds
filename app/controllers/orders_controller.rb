class OrdersController < ApplicationController
  before_action :get_cart

  # process order
  def create
    @order = Order.new(order_params)

    # Add items from cart to order's ordered_items association
    @cart.ordered_items.each do |item|
      @order.ordered_items << item
    end

    # Add shipping and tax to order total
    @order.total = BollingService.shipping_and_tax(params[:order][:shipping_method], @order.taxed_total)

    # Process credit card
    # Get credit card object from ActiveMerchant
    credit_card_service = CreditCardService.new(params[:card_info])

    # Check if card is valid
    if credit_card_service.credit_card.valid?
      options = { address: {}, billing_address: get_billing_address }

      # Make the purchase through ActiveMerchant
      charge_amount = (@order.total.to_f * 100).to_i
      response = gateway.purchase(charge_amount, credit_card, options)

      if !response.success?
        @order.errors.add(:error, "We couldn't process your credit card")
      end
    else
      @order.errors.add(:error, 'Your credit card seems to be invalid')
      flash[:error] = 'There was a problem processing your order. Please try again.'
      render :new && return
    end

    @order.order_status = 'processed'

    if @order.save
      # get rid of cart
      Cart.destroy(session[:cart_id])
      # send order confirmation email
      OrderMailer.order_confirmation(order_params[:billing_email], session[:order_id]).deliver
      flash[:success] = 'You successfully ordered!'
      redirect_to confirmation_orders_path
    else
      flash[:error] = 'There was a problem processing your order. Please try again.'
      render :new
    end
  end

  private

  def get_billing_address
    { name: "#{params[:billing_first_name]} #{params[:billing_last_name]}",
      address1: params[:billing_address_line_1],
      city: params[:billing_city], state: params[:billing_state],
      country: 'US',zip: params[:billing_zip],
      phone: params[:billing_phone] }
  end

  def order_params
    # We should avoid mass assignment if possible
    params.require(:order).permit!
  end

  def get_cart
    @cart = Cart.find(session[:cart_id])
  end
end