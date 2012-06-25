CheckoutController.class_eval do
  after_filter :update_user_address, :only => :update

  def before_address
    if current_user
      if current_user.ship_address
        @order.bill_address ||= current_user.ship_address
      else
        @order.bill_address ||= Address.default
      end
      if current_user.bill_address
        @order.ship_address ||= current_user.bill_address
      else
        @order.ship_address ||= Address.default
      end
    else
      @order.bill_address ||= Address.default
      @order.ship_address ||= Address.default
    end
  end

  def update_user_address

    if current_user
      unless params[:remember_bill_address].blank?
        current_user.bill_address = @order.bill_address
      end

      unless params[:remember_ship_address].blank?
        current_user.ship_address = @order.ship_address
      end
      current_user.save

    end
  end

end