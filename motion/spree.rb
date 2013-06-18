module Spree
  def self.endpoint
    @endpoint
  end

  def self.endpoint=(uri)
    @endpoint = uri
  end

  include Spree::API::Product
end
