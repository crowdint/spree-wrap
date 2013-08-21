class Spree::Order
  def self.fetch!(&block)
    Spree.order do |order, response|
      if response.ok?
        Spree.order_number  = order.number
        Spree.order_token   = order.token
        self.instance       = order
      end
      block.call(order, response) if block_given?
    end
  end

  def self.instance
    @instance ||= new
  end

  def self.instance=(value)
    @instance = value if value.class == Spree::Order
  end

  include Spree::Model

  define_model_attributes :id, :number, :item_total, :total, :state,
    :adjustment_total, :user_id, :created_at, :updated_at, :completed_at,
    :payment_total, :shipment_state, :payment_state, :email,
    :special_instructions, :token, :line_items
end
