module Spree
  module API
    module ResourceName
      def resource_name
        @resource_name ||= self.to_s.underscore.split('/').last
      end

      def resource_name_plural
        @resource_name_plural ||= Spree::Inflector.pluralize resource_name
      end
    end
  end
end
