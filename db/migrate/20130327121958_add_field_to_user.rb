class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :privacy, :boolean, :default => false, :after => :login
  end
end
