module Spree
  module API
    module Product
      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def products(&block)
          json = []

          BW::HTTP.get(Spree.products_uri) do |response|
            json = BW::JSON.parse(response.body.to_str)
            products = json["products"].map do |product_json|
              Spree::Product.new(product_json)
            end

            block.call products
          end

          json
        end

        def products_uri
          Spree.endpoint + "/products"
        end
      end
    end
  end
end
