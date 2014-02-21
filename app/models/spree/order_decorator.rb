Spree::Order.class_eval do
  before_validation :clone_shipping_address, :unless => :use_shipping?
  
  attr_accessor :use_shipping
  
  def clone_shipping_address
    if ship_address && ship_address.valid? and self.bill_address.nil?
      self.bill_address = ship_address.clone
    elsif ship_address && ship_address.valid?
      self.bill_address.attributes = ship_address.attributes.except('id', 'updated_at', 'created_at')
    end
    true
  end
  
  def billing_eq_shipping_address?
    (bill_address.empty? && ship_address.empty?) || ship_address.same_as?(bill_address)
  end
  
  private
  def use_shipping?
    @use_shipping == true || @use_shipping == "true" || @use_shipping == "1"
  end
end