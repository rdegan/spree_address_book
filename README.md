SpreeAddressBook
================

Adds the ability to save your billing and shipping address during registration or change in the account.
In addition, the user can also save addresses at checkout.
During the checkout will be offered automatically addresses previously set.


Installation
=======

gem 'spree_address_book', :git => 'git://github.com/rdegan/spree_address_book.git', :branch => '0.70-stable'

rails generate spree_address_book:install

Usage
=====

In this version there is a new view:  app / views / spree / users / update_addresses.html.erb, you can use this
view on account manager section for edit user's addresses.
For enter on this function there is a new route rule: user_update_addresses.
