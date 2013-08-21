module Spree
  class LineItem
    include Spree::Model

    define_model_attributes :id, :price, :quantity, :variant_id
  end
end
