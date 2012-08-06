Spree::UsersController.class_eval do
  include Spree::AddressHelper

  def update
    if @user.update_with_password(params)
      if params[:user][:password].present?
        # this logic needed b/c devise wants to log us out after password changes
        user = Spree::User.reset_password_by_token(params[:user])
        sign_in(@user, :event => :authentication, :bypass => !Spree::Auth::Config[:signout_after_password_change])
      end
      flash.notice = I18n.t("account_updated")
      redirect_to account_url
    else
      render 'edit'
    end
  end

  def update_addresses

    #if @user && @user.update_with_password(params)
    #      if params[:user][:password].present?
    #        # this logic needed b/c devise wants to log us out after password changes
    #        user = User.reset_password_by_token(params[:user])
    #        sign_in(@user, :event => :authentication, :bypass => !Spree::Auth::Config[:signout_after_password_change])
    #      end
    #      flash.notice = I18n.t("account_updated")
    #      redirect_to account_url
    #else
      @user = Spree::User.current
      @user.bill_address ||= Spree::Address.default
      @user.ship_address ||= Spree::Address.default
      #render 'edit'
    end
  end
