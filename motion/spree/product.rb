module Spree
  class Product
    include Spree::Model

    define_model_attributes :id, :taxon_ids, :permalink, :description, :option_types,
        :product_properties, :meta_description, :price, :available_on, :reviews,
        :name, :related_products, :meta_keywords, :variants
  end
end
