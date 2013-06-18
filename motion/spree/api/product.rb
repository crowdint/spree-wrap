module Spree
  module API
    module Product
      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def products
          []
        end
      end
    end
  end
end
