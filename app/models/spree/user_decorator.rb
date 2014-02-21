Spree.user_class.class_eval do
  
  
  has_many :ship_addresses, class_name: 'Spree::Address'
  accepts_nested_attributes_for :bill_address, allow_destroy: true
  accepts_nested_attributes_for :ship_addresses, allow_destroy: true
  
  after_update :removed_bill_address, if: :delete_billing?
  attr_accessor :delete_bill_address

  def update_with_password(params = {})
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?
    params.delete(:bill_address_attributes) if empty_address?(params[:bill_address_attributes])
    update_attributes(params)
  end

  def removed_bill_address
    if self.bill_address
      self.bill_address.destroy
    end      
  end

  def delete_billing?
    @delete_bill_address == true || @delete_bill_address == "true" || @delete_bill_address == "1"
  end  
end