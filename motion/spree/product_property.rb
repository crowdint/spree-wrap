module Spree
  class ProductProperty
    include Spree::Model

    define_model_attributes :id, :product_id, :property_id, :value, :property_name
  end
end
