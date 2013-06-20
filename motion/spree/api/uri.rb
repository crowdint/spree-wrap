module Spree
  module API
    module URI
      def self.included(base)
        base.send :define_method, "#{base.resource_name_plural}_uri" do
          "#{Spree.endpoint}/#{base.resource_name_plural}"
        end

        base.send :define_method, "#{base.resource_name}_uri" do |id|
          "#{Spree.endpoint}/#{base.resource_name_plural}/#{id}"
        end

        base.send :define_method, "#{base.resource_name}_search_uri" do |query|
          "#{Spree.endpoint}/#{base.resource_name_plural}?#{query}"
        end
      end
    end
  end
end
