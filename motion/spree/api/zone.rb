module Spree
  module API
    #
    # This module defines all the API calls related to Zones.
    # All results return Spree::Zone objects.
    #
    # API Reference
    #
    # http://api.spreecommerce.com/v1/zones
    #
    # This Module is included in the Spree Module so you should call its
    # methods directly from Spree.
    #
    #   Spree.zones do |zones|
    #     # ...
    #   end
    #
    module Zone
      extend Spree::API::ResourceName
      include Spree::API::Query
      include Spree::API::URI

      #
      # List zones visible to the authenticated user.
      #
      #   Spree.zones do |zones|
      #     # ..
      #   end
      #
      def zones(&block)
        collection_query("zones", Spree::Zone, Spree.zones_uri, &block)
      end

      #
      # To view the details for a single zone, make a request using that zone's permalink:
      #
      #   Spree.zone("a-zone") do |zone|
      #     # ...
      #   end
      #
      # You may also query by the zone's id attribute:
      #
      #   Spree.zone("id") do |zone|
      #     # ...
      #   end
      #
      # Note that the API will attempt a permalink lookup before an ID lookup.
      #
      def zone(id, &block)
        object_query(Spree::Zone, zone_uri(id), &block)
      end
    end
  end
end

