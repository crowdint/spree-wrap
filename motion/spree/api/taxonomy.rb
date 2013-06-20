module Spree
  module API
    #
    # This module defines all the API calls related to Taxonomies.
    # All results return Spree::Taxonomy objects.
    #
    # API Reference
    #
    # http://api.spreecommerce.com/v1/taxonomies
    #
    # This Module is included in the Spree Module so you should call its
    # methods directly from Spree.
    #
    #   Spree.taxonomies do |taxonomies|
    #     # ...
    #   end
    #
    module Taxonomy
      extend Spree::API::ResourceName
      include Spree::API::Query
      include Spree::API::URI

      #
      # To get a list of all the taxonomies, including their root nodes and
      # the immediate children for the root node, make a request like this:
      #
      #   Spree.taxonomies do |taxonomies|
      #     # ..
      #   end
      #
      def taxonomies(&block)
        collection_query("taxonomies", Spree::Taxonomy, Spree.taxonomies_uri, &block)
      end

      # To get information for a single taxonomy, including its root node and
      # the immediate children of the root node, make a request like this:
      #
      #   Spree.taxonomy(1) do |taxonomy|
      #     # ...
      #   end
      #
      def taxonomy(id, &block)
        object_query(Spree::Taxonomy, taxonomy_uri(id), &block)
      end
    end
  end
end
