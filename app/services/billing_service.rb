class BollingService
  def self.shipping_and_tax(shipping_method, taxed_total)
    case shipping_method
      when 'ground'
        taxed_total.round(2)
      when 'two-day'
        (taxed_total + 15.75).round(2)
      when 'overnight'
        (taxed_total + 25).round(2)
    end
  end
end