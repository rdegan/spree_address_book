Spree::CheckoutController.class_eval do
  after_filter :update_user_address, :only => :update
  
  def registration
    @user = Spree::User.new
    @user.bill_address ||= Spree::Address.default
    @user.ship_address ||= Spree::Address.default
  end
  
  def before_address
    if current_user
      @order.bill_address ||= current_user.bill_address || Spree::Address.default
      @order.ship_address ||= current_user.ship_address || Spree::Address.default
    else
      @order.bill_address ||= Spree::Address.default
      @order.ship_address ||= Spree::Address.default
    end
  end
  
  def update_user_address
    unless params[:remember_bill_address].blank?
      current_user.bill_address = @order.bill_address
    end

    unless params[:remember_ship_address].blank?
          current_user.ship_address = @order.ship_address
    end
    current_user.save

  end

end