module Spree
  module API
    #
    # This module defines all the API calls related to Countries.
    # All results return Spree::Country objects.
    #
    # API Reference
    #
    # http://api.spreecommerce.com/v1/countries
    #
    # This Module is included in the Spree Module so you should call its
    # methods directly from Spree.
    #
    #   Spree.countries do |countries|
    #     # ...
    #   end
    #
    module Country
      extend Spree::API::ResourceName
      include Spree::API::Query
      include Spree::API::URI

      #
      # Retrieve a list of all countries by making this request:
      #
      #   Spree.countries do |countries|
      #     # ..
      #   end
      #
      def countries(&block)
        collection_query("countries", Spree::Country, Spree.countries_uri, &block)
      end

      #
      # Retrieve details about a particular country:
      #
      #   Spree.country(1) do |country|
      #     # ...
      #   end
      #
      def country(id, &block)
        object_query(Spree::Country, country_uri(id), &block)
      end
    end
  end
end
