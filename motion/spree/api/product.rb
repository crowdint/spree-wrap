module Spree
  module API
    module Product
      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def products(&block)
          BW::HTTP.get(Spree.products_uri) do |response|
            json = BW::JSON.parse(response.body.to_str)
            products = json["products"].map do |product_json|
              Spree::Product.new(product_json)
            end

            block.call products
          end
        end

        def product(id, &block)
          BW::HTTP.get(Spree.product_uri(id)) do |response|
            json = BW::JSON.parse(response.body.to_str)
            product = Spree::Product.new(json)

            block.call product
          end
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
