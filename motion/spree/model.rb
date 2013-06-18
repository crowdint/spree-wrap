module Spree
  module Model
    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def define_model_attributes(*attrs)
        define_method :attributes do
          attrs
        end

        attrs.each do |attr|
          attr_accessor attr
        end
      end
    end

    def initialize(attributes = {})
      self.attributes.each do |attr|
        send("#{attr}=", attributes[attr.to_s])
      end
    end
  end
end
