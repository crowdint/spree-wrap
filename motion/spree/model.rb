module Spree
  #
  # This module defines common behavior for all the Models
  #
  module Model
    extend MotionSupport::Concern

    module ClassMethods
      #
      # Define the properties or attributes of the model.
      #
      def define_model_attributes(*attrs)
        define_method :attributes do
          attrs
        end

        attrs.each do |attr|
          attr_accessor attr
        end
      end
    end

    #
    # The initializer receives a hash with the attributes
    #
    def initialize(attributes = {})
      self.attributes.each do |attr|
        send("#{attr}=", attributes[attr.to_s])
      end
    end
  end
end
