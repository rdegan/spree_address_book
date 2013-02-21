Spree::UserRegistrationsController.class_eval do
  include Spree::AddressHelper
  
  def new
    resource = build_resource({})
    @user.bill_address ||= Spree::Address.default
    @user.ship_address ||= Spree::Address.default
    respond_with resource
  end
  
  def create
     params[:user].delete(:bill_address_attributes) if params[:user][:bill_address_attributes].blank? || empty_address?(params[:user][:bill_address_attributes])
     params[:user].delete(:ship_address_attributes) if params[:user][:ship_address_attributes].blank? || empty_address?(params[:user][:ship_address_attributes])
    super
  end
end