module Spree
  module API

    module Order
      extend Spree::API::ResourceName
      include Spree::API::Query

      def order(&block)
        object_query(Spree::Order, "#{Spree.endpoint}/order", &block)
      end

    end
  end
end
