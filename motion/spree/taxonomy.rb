module Spree
  class Taxonomy
    include Spree::Model

    define_model_attributes :id, :name, :root
  end
end
