#
# This module contains all the methods required to consume the Spree API.
#
# Refer to the modules on the Spree::API namespace for more information.
#
# Spree::API::Country
# Spree::API::Product
# Spree::API::Taxonomy
# Spree::API::Variant
# Spree::API::Zone
#
module Spree
  class << self
    attr_accessor :endpoint,
                  :authentication_endpoint,
                  :registration_endpoint
  end

  def self.token
    App::Persistence['SPREE_TOKEN']
  end

  def self.token=(value)
    App::Persistence['SPREE_TOKEN'] = value
  end

  def self.order_token
    App::Persistence['SPREE_ORDER_TOKEN']
  end

  def self.order_token=(value)
    App::Persistence['SPREE_ORDER_TOKEN'] = value
  end

  def self.order_number
    App::Persistence['SPREE_ORDER_NUMBER']
  end

  def self.order_number=(value)
    App::Persistence['SPREE_ORDER_NUMBER'] = value
  end

  def self.cookie
    App::Persistence['SPREE_COOKIE']
  end

  def self.cookie=(value)
    App::Persistence['SPREE_COOKIE'] = value
  end

  extend Spree::API::Country
  extend Spree::API::Order
  extend Spree::API::Product
  extend Spree::API::ProductProperty
  extend Spree::API::Taxonomy
  extend Spree::API::Variant
  extend Spree::API::Zone
end
