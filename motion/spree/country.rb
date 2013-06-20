module Spree
  class Country
    include Spree::Model

    define_model_attributes :id, :iso_name, :iso, :name, :iso3, :numcode, :states
  end
end
