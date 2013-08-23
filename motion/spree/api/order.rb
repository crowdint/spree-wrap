module Spree
  module API

    module Order
      extend Spree::API::ResourceName
      include Spree::API::Query

      def order(&block)
        object_query(Spree::Order, "#{Spree.endpoint}/order", &block)
      end

      def current_order(&block)
        object_query(Spree::Order, "#{Spree.endpoint}/orders/#{Spree.order_number}", &block)
      end

    end
  end
end
