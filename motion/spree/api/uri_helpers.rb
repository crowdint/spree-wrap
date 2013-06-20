module Spree
  module API
    module URIHelpers
      def self.included(base)
        base.send :define_method, "#{base.resource_name_plural}_uri" do
          "#{Spree.endpoint}/#{base.resource_name_plural}"
        end

        base.send :define_method, "#{base.resource_name}_uri" do |id|
          "#{Spree.endpoint}/#{base.resource_name_plural}/#{id}"
        end
      end
    end
  end
end
