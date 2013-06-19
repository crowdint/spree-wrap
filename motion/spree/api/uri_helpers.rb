module Spree
  module API
    module URIHelpers
      def self.included(base)
        resource = extract_resource_name(base.to_s)
        resources = Spree::Inflector.pluralize resource

        base.send :define_method, "#{resources}_uri" do
          "#{Spree.endpoint}/#{resources}"
        end

        base.send :define_method, "#{resource}_uri" do |id|
          "#{Spree.endpoint}/#{resources}/#{id}"
        end
      end

      #
      # Extracts the underscored resource name from the class name
      #
      # Example, for Spree::Product::ClassMethods it returns:
      #
      #   product
      #
      def self.extract_resource_name(class_name)
        class_name =~ /(.+)::(.+)::ClassMethods/
        $2.underscore
      end
    end
  end
end
