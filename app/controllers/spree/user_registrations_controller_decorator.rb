Spree::UserRegistrationsController.class_eval do
  include Spree::AddressHelper
  
  def new
    resource = build_resource({})
    country = Spree::Country.find(Spree::Config[:default_country_id]) rescue Spree::Country.first
    @user.build_bill_address({:country => country}, :without_protection => true) if !@user.bill_address
    @user.build_ship_address({:country => country}, :without_protection => true) if !@user.ship_address
    respond_with @user
  end
  
  def create
     params[:user].delete(:bill_address_attributes) if params[:user][:bill_address_attributes].blank? || empty_address?(params[:user][:bill_address_attributes])
     params[:user].delete(:ship_address_attributes) if params[:user][:ship_address_attributes].blank? || empty_address?(params[:user][:ship_address_attributes])
     super
  end
end