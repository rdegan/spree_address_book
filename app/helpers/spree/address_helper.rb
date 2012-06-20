module Spree
  module AddressHelper
    def empty_address?(address)
      count = 0
      count += 1 if  address[:firstname].blank?
      count += 1 if  address[:lastname].blank?
      count += 1 if  address[:address1].blank?
      count += 1 if  address[:city].blank?
      count += 1 if  address[:state_id].blank?
      count += 1 if  address[:zipcode].blank?
      count += 1 if  address[:phone].blank?
      if count == 7
        true
      else
        false
      end
    end
  end
end