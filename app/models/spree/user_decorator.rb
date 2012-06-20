Spree::User.class_eval do
  attr_accessible :email, :password, :password_confirmation, :remember_me, :persistence_token,  :ship_address, :ship_address_attributes, :bill_address, :bill_address_attributes
  accepts_nested_attributes_for :ship_address
  accepts_nested_attributes_for :bill_address

  def update_with_password(params = {})
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    if params[:user].key?(:bill_address_attributes)
    params[:user].delete(:bill_address_attributes) if  empty_address?(params[:user][:bill_address_attributes]) || params[:delete_bill_address] == 'ture'
    end
    if params[:user].key?(:ship_address_attributes)
    params[:user].delete(:ship_address_attributes) if empty_address?(params[:user][:ship_address_attributes]) || params[:delete_ship_address] == 'ture'
    end
    r = update_attributes(params[:user])
    self.ship_address.delete if !params[:delete_ship_address].nil? && params[:delete_ship_address] == 'true' && !self.ship_address.nil?
    self.bill_address.delete if !params[:delete_bill_address].nil? && params[:delete_bill_address] == 'true' && !self.bill_address.nil?
    r
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