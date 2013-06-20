module Spree
  module API
    #
    # This module defines all the API calls related to Variants.
    # All results return Spree::Variant objects.
    #
    # API Reference
    #
    # http://api.spreecommerce.com/v1/variants
    #
    # This Module is included in the Spree Module so you should call its
    # methods directly from Spree.
    #
    #   Spree.variants do |variants|
    #     # ...
    #   end
    #
    module Variant
      extend Spree::API::ResourceName
      include Spree::API::Query
      include Spree::API::URI

      # To return a paginated list of all variants within the store, make this request:
      #
      #   Spree.variants do |variants|
      #     # ..
      #   end
      #
      def variants(&block)
        collection_query("variants", Spree::Variant, Spree.variants_uri, &block)
      end

      #
      # To view the details for a single variant, make a request using that
      # variant's id, along with its product_id:
      #
      #   product_id = 1
      #
      #   Spree.product_variants(product_id) |v|
      #     # ...
      #   end
      #
      def product_variants(product_id, &block)
        collection_query("variants", Spree::Variant, Spree.product_variants_uri(product_id), &block)
      end

      def product_variants_uri(product_id)
        Spree.product_uri(product_id) + "/variants"
      end
    end
  end
end
