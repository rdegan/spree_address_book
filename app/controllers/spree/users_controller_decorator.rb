Spree::UsersController.class_eval do
  include Spree::AddressHelper
  
  def edit
    @user.bill_address ||= Spree::Address.default
    @user.ship_address ||= Spree::Address.default
  end
  
  def update
    if @user.update_with_password(params[:user])
      if params[:user][:password].present?
        # this logic needed b/c devise wants to log us out after password changes
        user = Spree::User.reset_password_by_token(params[:user])
        sign_in(@user, :event => :authentication, :bypass => !Spree::Auth::Config[:signout_after_password_change])
      end
      redirect_to spree.account_url, :notice => t(:account_updated)
    else
      render :edit
    end
  end
end

