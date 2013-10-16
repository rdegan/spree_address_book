Spree::Order.class_eval do
  validate :has_valid_bill_address
  
  def has_valid_bill_address
    return unless :address == state_name.to_sym
    return unless bill_address && bill_address.valid?
    errors.add(:base, :no_valid_bill_address) if !bill_address.empty? && (bill_address.vat_number.blank? && bill_address.tax_id_number.blank?)
  end
end
