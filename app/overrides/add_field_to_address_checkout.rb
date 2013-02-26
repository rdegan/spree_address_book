Deface::Override.new(:virtual_path => "spree/checkout/_address",
                     :name => "append_field_bill_address_checkout",
                     :insert_after => "[id='blastname']",
                     :partial => "spree/shared/bill_address_field_company")

Deface::Override.new(:virtual_path => "spree/checkout/_address",
                     :name => "append_field_ship_address_checkout",
                     :insert_after => "[id='slastname']",
                     :partial => "spree/shared/ship_address_field_company")