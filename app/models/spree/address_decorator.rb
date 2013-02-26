Spree::Address.class_eval do
  attr_accessible :tax_id_number, :vat_number
  
  validates :vat_number, :length => {:maximum => 11}, :if => Proc.new {|a| !a.vat_number.blank? }
  validates :tax_id_number, :length => {:in => 11..16}, :if => Proc.new {|a| !a.tax_id_number.blank? }
  
  def empty?
    attributes.except('id', 'created_at', 'updated_at', 'order_id', 'country_id', 'tax_id_number', 'vat_number').all? { |_, v| v.nil? }
  end
end