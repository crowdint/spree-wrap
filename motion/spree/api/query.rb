module Spree
  module API
    module Query
      def collection_query(collection_name, object_class, uri, &block)
        if block_given?
          BW::HTTP.get(uri, default_query_headers) do |response|
            if response.ok?
              json       = BW::JSON.parse(response.body.to_str)
              collection = (json[collection_name] || []).map do |object_json|
                object_class.new(object_json)
              end
            else
              collection = []
            end

            block.call collection, response
          end
        else
          BW::HTTP.get(uri)
        end
      end

      def object_query(object_class, uri, &block)
        if block_given?
          BW::HTTP.get(uri, default_query_headers) do |response|
            if response.ok?
              json   = BW::JSON.parse(response.body.to_str)
              object = object_class.new(json)
            else
              object = nil
            end

            block.call object, response
          end
        else
          BW::HTTP.get(uri)
        end
      end

      private
      def default_query_headers
        { headers: {
          "Accept"        => "application/json",
          "Cookie"        => Spree.cookie,
          "X-Spree-Token" => Spree.token
        }}
      end
    end
  end
end
