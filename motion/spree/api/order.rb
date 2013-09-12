module Spree
  module API

    module Order
      extend Spree::API::ResourceName
      include Spree::API::Query

      def order(&block)
        object_query(Spree::Order, "#{Spree.endpoint}/order", &block)
      end

      def current_order(&block)
        object_query(Spree::Order, current_order_uri, &block)
      end

      def current_order_uri
        "#{Spree.endpoint}/orders/#{Spree.order_number}"
      end

      def current_checkout_uri
        "#{Spree.endpoint}/checkouts/#{Spree.order_number}"
      end

      def checkout_next_state_uri
        "#{Spree.endpoint}/checkouts/#{Spree.order_number}/next"
      end

      def advance_current_order(&block)
        if block_given?
          BW::HTTP.put(checkout_next_state_uri, w_request) do |response|
            json = BW::JSON.parse(response.body)
            Spree::Order.instance = Spree::Order.new(json) if response.ok?
            block.call(json, response)
          end
        else
          BW::HTTP.put(current_order_uri, w_request)
        end
      end

      private
      def w_request
        {
          headers: {
            "Accept"        => "application/json",
            "Content-Type"  => "application/json",
            "Cookie"        => Spree.cookie,
            "X-Spree-Token" => Spree.token
          },
          payload: Spree::Order.instance.to_json
        }
      end

    end
  end
end
