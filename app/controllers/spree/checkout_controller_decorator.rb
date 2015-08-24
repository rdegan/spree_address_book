Spree::CheckoutController.class_eval do
	def registration
		@user = Spree::User.new
		country = Spree::Country.find(Spree::Config[:default_country_id]) rescue Spree::Country.first
		@user.build_bill_address({:country => country}, :without_protection => true) if !@user.bill_address
		@user.build_ship_address({:country => country}, :without_protection => true) if !@user.ship_address
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