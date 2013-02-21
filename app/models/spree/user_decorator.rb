Spree::User.class_eval do
  attr_accessible :use_billing, :bill_address_attributes, :ship_address_attributes, :ship_address, :bill_address
  accepts_nested_attributes_for :bill_address, :allow_destroy => true
  accepts_nested_attributes_for :ship_address, :allow_destroy => true
  
  before_validation :clone_billing_address, :if => :use_billing?
  attr_accessor :use_billing
  
  def update_with_password(params = {})
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    params[:user].delete(:bill_address_attributes) if empty_address?(params[:user][:bill_address_attributes]) || params[:delete_bill_address] == 'ture'
    params[:user].delete(:ship_address_attributes) if empty_address?(params[:user][:ship_address_attributes]) || params[:delete_ship_address] == 'ture'
    update_attributes(params[:user])
    self.ship_address.destroy if params[:delete_ship_address] == 'true' && !self.ship_address.nil?
    self.bill_address.destroy if params[:delete_bill_address] == 'true' && !self.bill_address.nil?
  end
  
  def clone_billing_address
    if bill_address and self.ship_address.nil?
      self.ship_address = bill_address.clone
    else
      self.ship_address.attributes = bill_address.attributes.except('id', 'updated_at', 'created_at')
    end
    true
  end

  def use_billing?
    @use_billing == true || @use_billing == "true" || @use_billing == "1"
  end
  
  private
  def empty_address?(address)
    count = 0
    count += 1 if  address[:firstname].blank?
    count += 1 if  address[:lastname].blank?
    count += 1 if  address[:address1].blank?
    count += 1 if  address[:city].blank?
    count += 1 if  address[:state_id].blank?
    count += 1 if  address[:zipcode].blank?
    count += 1 if  address[:phone].blank?
    if count == 7
      true
    else
      false
    end
  end
end