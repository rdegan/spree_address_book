Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  match "/update_addresses" => 'users#update_addresses', :as => :user_update_addresses
end
