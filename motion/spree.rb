#
# This module contains all the methods required to consume the Spree API.
#
# Refer to the modules on the Spree::API namespace for more information.
#
# Spree::API::Product
#
module Spree
  #
  # Getter for the endpoint URL
  #
  def self.endpoint
    @endpoint
  end

  #
  # Setter for the endpoint URL
  #
  def self.endpoint=(uri)
    @endpoint = uri
  end

  extend Spree::API::Country
  extend Spree::API::Product
  extend Spree::API::Taxonomy
  extend Spree::API::Variant
  extend Spree::API::Zone
end
