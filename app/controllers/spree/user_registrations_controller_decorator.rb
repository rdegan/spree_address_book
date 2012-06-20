Spree::UserRegistrationsController.class_eval do
  include Spree::AddressHelper
  def create
     params[:user].delete(:bill_address_attributes) if params[:user][:bill_address_attributes].blank? || empty_address?(params[:user][:bill_address_attributes])
     params[:user].delete(:ship_address_attributes) if params[:user][:ship_address_attributes].blank? || empty_address?(params[:user][:ship_address_attributes])
    super
  end
end