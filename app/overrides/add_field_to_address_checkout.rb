Deface::Override.new(:virtual_path => "spree/shared/_user_form",
                     :name => "add_address_user",
                     :insert_after => "[data-hook='signup_below_password_fields']",
                     :partial => "spree/shared/address_user_form")

Deface::Override.new(:virtual_path => "spree/address/_form",
                     :name => "append_fields_address_checkout",
                     :insert_after => "[id='bcompany']",
                     :partial => "spree/shared/tax_id_and_vat_number_form")

Deface::Override.new(:virtual_path => "spree/address/_form",
                     :name => "append_fields_address_checkout",
                     :insert_after => "[id='blastname']",
                     :partial => "spree/shared/tax_id_and_vat_number_form")
