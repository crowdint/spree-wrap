module Spree
  module API
    module Product
      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      #
      # This module defines all the API calls related to Products.
      # All results return Spree::Product objects.
      #
      # API Reference
      #
      # http://api.spreecommerce.com/v1/products/#list-products
      #
      module ClassMethods
        include Query

        #
        # List products visible to the authenticated user.
        #
        #   Spree.products do |products|
        #     # ..
        #   end
        #
        def products(&block)
          collection_query("products", Spree::Product, Spree.products_uri, &block)
        end

        #
        # To view the details for a single product, make a request using that product's permalink:
        #
        #   Spree.product("a-product") do |product|
        #     # ...
        #   end
        #
        # You may also query by the product's id attribute:
        #
        #   Spree.product("id") do |product|
        #     # ...
        #   end
        #
        # Note that the API will attempt a permalink lookup before an ID lookup.
        #
        def product(id, &block)
          object_query(Spree::Product, product_uri(id), &block)
        end

        def products_uri
          Spree.endpoint + "/products"
        end

        def product_uri(id)
          products_uri + "/#{id}"
        end
      end
    end
  end
end
