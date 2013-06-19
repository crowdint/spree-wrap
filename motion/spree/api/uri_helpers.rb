module Spree
  module API
    module URIHelpers
      def self.included(base)
        resource  = Spree::Inflector.extract_resource_name(base.to_s)
        resources = Spree::Inflector.pluralize resource

        base.send :define_method, "#{resources}_uri" do
          "#{Spree.endpoint}/#{resources}"
        end

        base.send :define_method, "#{resource}_uri" do |id|
          "#{Spree.endpoint}/#{resources}/#{id}"
        end
      end
    end
  end
end
