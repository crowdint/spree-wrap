module Spree
  class User
    include Spree::Model

    define_model_attributes :bill_address_id, :created_at, :email, :id,
      :last_request, :login, :name, :password, :password_confirmation,
      :perishable_token, :persistence_token, :provider, :ship_address_id,
      :spree_api_key, :uid, :updated_at

  end
end
