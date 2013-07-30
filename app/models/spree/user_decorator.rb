Spree::User.class_eval do
  attr_accessible :bill_address_attributes, :ship_address_attributes,
                  :ship_address, :bill_address, :privacy, :save_ship, :save_bill
  
  attr_accessor :save_ship, :save_bill, :delete_ship_address, :delete_bill_address
  
  accepts_nested_attributes_for :bill_address, :allow_destroy => true
  accepts_nested_attributes_for :ship_address, :allow_destroy => true
  
  after_update :removed_bill_address, :if => :delete_bill?
  after_update :removed_ship_address, :if => :delete_ship?
  
  validates_acceptance_of :privacy, :allow_nil => false, :accept => true, :if => :privacy_required?
  
  def update_with_password(params = {})
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?
    if params[:bill_address_attributes] || params[:ship_address_attributes]
      params.delete(:bill_address_attributes) if empty_address?(params[:bill_address_attributes])
      params.delete(:ship_address_attributes) if empty_address?(params[:ship_address_attributes])
    end
    update_attributes(params)
  end
  
  def privacy_required?
    if self.new_record?
      user_authentications.where(:provider => 'facebook').blank? &&
      reset_password_sent_at.blank?
    end
  end
  
  def removed_ship_address
    if self.ship_address
      self.ship_address.destroy
    end
  end
  
  def removed_bill_address
    if self.bill_address
      self.bill_address.destroy
    end      
  end
  
  def delete_bill?
    @delete_bill_address == true || @delete_bill_address == "true" || @delete_bill_address == "1"
  end
  
  def delete_ship?
    @delete_ship_address == true || @delete_ship_address == "true" || @delete_ship_address == "1"
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