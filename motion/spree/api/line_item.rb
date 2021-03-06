module Spree
  module API
    module LineItem
      extend Spree::API::ResourceName
      include Spree::API::Query
      include Spree::API::URI

      def line_items_uri
        "#{Spree.endpoint}/orders/#{Spree.order_number}/line_items"
      end

      def line_item_uri(id)
        "#{line_items_uri}/#{id}"
      end

      def create_line_item(attributes, &block)
        if block_given?
          BW::HTTP.post(line_items_uri, create_line_item_request(attributes)) do |response|
            if response.ok?
              json = BW::JSON.parse response.body
              line_item = Spree::LineItem.new(json)
            else
              line_item = nil
            end

            block.call(line_item, response)
          end
        else
          BW::HTTP.post(line_items_uri, create_line_item_request(attributes))
        end
      end

      def update_line_item(attributes, &block)
        if block_given?
          BW::HTTP.put(line_item_uri(attributes[:id]), create_line_item_request(attributes)) do |response|
            if response.ok?
              json = BW::JSON.parse response.body
              line_item = Spree::LineItem.new(json)
            else
              line_item = nil
            end

            block.call(line_item, response)
          end
        else
          BW::HTTP.put(line_item_uri(attributes[:id]), create_line_item_request(attributes))
        end
      end

      def delete_line_item(id, &block)
        block_present = block_given?
        BW::HTTP.delete(line_item_uri(id), {headers: default_headers}) do |response|
          block.call(response) if block_present
        end
      end

      private

      def create_line_item_request(options)
        {
          payload: BW::JSON.generate({
            line_item: {
              variant_id: options[:variant_id],
              quantity:   (options[:quantity] || 1)
            }
          }),
          headers: default_headers
        }
      end

      def default_headers
        {
          "Accept"        => "application/json",
          "Content-Type"  => "application/json",
          "Cookie"        => Spree.cookie,
          "X-Spree-Token" => Spree.token
        }
      end
    end
  end
end
