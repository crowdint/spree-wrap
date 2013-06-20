module Spree
  module API
    #
    # This module defines all the API calls related to Products.
    # All results return Spree::Product objects.
    #
    # API Reference
    #
    # http://api.spreecommerce.com/v1/products
    #
    # This Module is included in the Spree Module so you should call its
    # methods directly from Spree.
    #
    #   Spree.products do |products|
    #     # ...
    #   end
    #
    module Product
      extend Spree::API::ResourceName
      include Spree::API::Query
      include Spree::API::URI

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

      #
      # To search for a particular product, make a request like this:
      #
      #   Spree.product_search("q[name_cont]=Spree") do |p|
      #     # ...
      #   end
      #
      # The searching API is provided through the Ransack gem which Spree
      # depends on. The name_cont here is called a predicate, and you can
      # learn more about them by reading about
      # {Predicates on the Ransack wiki}[https://github.com/ernie/ransack/wiki/Basic-Searching].
      #
      def product_search(query, &block)
        collection_query("products", Spree::Product, Spree.product_search_uri(query), &block)
      end
    end
  end
end
