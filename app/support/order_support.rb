class OrderSupport
  def self.total_shipping_charge(order)
    case order.name
      when 'ahmad'
        #order.total = (@order.taxed_total).round(2)
        'Hello AHmad'
      when 'Hassan'
        'Hello Hassan'
        #order.total = @order.taxed_total + (15.75).round(2)
      when 'overnight'
        #order.total = @order.taxed_total + (25).round(2)
    end
  end
end