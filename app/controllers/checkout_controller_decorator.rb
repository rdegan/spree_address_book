CheckoutController.class_eval do
  after_filter :update_user_address, :only => :update

  def before_address
    if current_user
      @order.bill_address ||= current_user.bill_address || Address.default
      @order.ship_address ||= current_user.ship_address || Address.default
    else
      @order.bill_address ||= Address.default
      @order.ship_address ||= Address.default
    end
  end

  def update_user_address
    unless params[:remember_bill_address].blank?
      current_user.bill_address.delete unless current_user.bill_address.blank?
      current_user.bill_address = @order.bill_address.clone
    end

    unless params[:remember_ship_address].blank?
          current_user.ship_address.delete unless current_user.ship_address.blank?
          current_user.ship_address = @order.ship_address.clone
    end
    current_user.save

  end

end