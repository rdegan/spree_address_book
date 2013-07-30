Spree::Address.class_eval do
  attr_accessible :tax_id_number, :vat_number
  
  validates_format_of :tax_id_number, :with => /^[A-Z]{6}[A-Z0-9]{2}[A-Z][A-Z0-9]{2}[A-Z][A-Z0-9]{3}[A-Z]$/i, :if => :fiscal_code_present?
  validates :vat_number, :length => {:maximum => 11}, :if => Proc.new {|a| !a.vat_number.blank? }
  validates :tax_id_number, :length => {:in => 11..16}, :if => :fiscal_code_present?
  
  def empty?
    attributes.except('id', 'created_at', 'updated_at', 'order_id', 'country_id', 'tax_id_number', 'vat_number').all? { |_, v| v.nil? }
  end
  
  def fiscal_code_present?
    !tax_id_number.blank?
  end
end