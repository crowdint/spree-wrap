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

  include Spree::API::Product
end
