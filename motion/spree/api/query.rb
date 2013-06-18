module Spree
  module API
    module Query
      def collection_query(collection_name, object_class, uri, block)
        BW::HTTP.get(uri) do |response|
          json       = BW::JSON.parse(response.body.to_str)
          collection = json[collection_name].map do |object_json|
            object_class.new(object_json)
          end

          block.call collection
        end
      end

      def object_query(object_class, uri, block)
        BW::HTTP.get(uri) do |response|
          json   = BW::JSON.parse(response.body.to_str)
          object = object_class.new(json)

          block.call object
        end
      end
    end
  end
end
