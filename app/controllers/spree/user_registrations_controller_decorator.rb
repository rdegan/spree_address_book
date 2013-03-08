Spree::UserRegistrationsController.class_eval do
  include Spree::AddressHelper
  
  def new
    resource = build_resource({})
    @user.bill_address ||= Spree::Address.default
    @user.ship_address ||= Spree::Address.default
    respond_with resource
  end
  
  def create
     params[:user].delete(:bill_address) if params[:user][:bill_address].blank? || empty_address?(params[:user][:bill_address])
     params[:user].delete(:ship_address) if params[:user][:ship_address].blank? || empty_address?(params[:user][:ship_address])
    super
  end
end