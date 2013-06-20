module Spree
  class Zone
    include Spree::Model

    define_model_attributes :id, :name, :descriptions, :zone_members
  end
end
