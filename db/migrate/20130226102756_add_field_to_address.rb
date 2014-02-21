class AddFieldToAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :tax_id_number, :string, :limit => 16, :after => :company
    add_column :spree_addresses, :vat_number, :string, :limit => 11, :after => :tax_id_number
    
    add_column :spree_addresses, :user_id, :integer, :after => :country_id
  end
end
