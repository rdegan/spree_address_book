class AddFieldToAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :tax_id_number, :string, :limit => 16, :after => :lastname
    add_column :spree_addresses, :vat_number, :string, :limit => 11, :after => :tax_id_number
  end
end
