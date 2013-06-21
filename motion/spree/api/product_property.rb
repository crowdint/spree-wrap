module Spree
  module API
    # == Product Properties
    #
    # === API Reference
    #
    # http://api.spreecommerce.com/v1/product/properties/
    #
    module ProductProperty
      extend Spree::API::ResourceName
      include Spree::API::Query
      include Spree::API::URI

      #
      # Retrieve a list of all product properties for a product by making this request:
      #
      #   product_id = 1
      #   Spree.product_properties(1) do |property|
      #     # ...
      #   end
      #
      def product_properties(id, &block)
        collection_query("product_properties", Spree::ProductProperty,
                           product_properties_uri(id), &block)
      end

      #
      # To search for a particular product property, make a request like this:
      #
      #   product_id = 1
      #   query      = "q[property_name_cont]=Type"
      #
      #   Spree.product_property_search(product_id, query) do |p|
      #     # ...
      #   end
      # The searching API is provided through the Ransack gem which
      # Spree depends on. The property_name_cont here is called a predicate,
      # and you can learn more about them by reading
      # about {Predicates on the Ransack wiki}[https://github.com/ernie/ransack/wiki/Basic-Searching].
      #
      def product_property_search(product_id, query, &block)
        collection_query("product_properties", Spree::ProductProperty,
                           Spree.product_property_search_uri(product_id, query), &block)
      end

      def product_properties_uri(product_id)
        Spree.product_uri(product_id) + "/product_properties"
      end

      def product_property_search_uri(product_id, query)
        Spree.product_uri(product_id) + "/product_properties?#{query}"
      end
    end
  end
end
