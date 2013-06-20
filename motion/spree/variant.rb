module Spree
  class Variant
    include Spree::Model

    define_model_attributes :id, :stock_items, :option_values, :permalink,
        :sku, :weight, :product_id, :images, :depth, :price, :height, :name,
        :width, :cost_price, :is_master
  end
end
