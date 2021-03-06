class Spree::Order
  def self.fetch!(&block)
    block_present = block_given?
    Spree.order do |order, response|
      if response.ok?
        Spree.order_number  = order.number
        Spree.order_token   = order.token
        self.instance       = order
      end
      block.call(order, response) if block_present
    end
  end

  def self.instance
    @instance ||= new
  end

  def self.instance=(value)
    @instance = value if value.class == Spree::Order
  end

  def refresh(&block)
    block_present = block_given?
    Spree.current_order do |order, response|
      self.line_items = order.line_items
      if block_present
        block.call order.line_items, response
      end
    end
  end

  include Spree::Model

  define_model_attributes :id, :number, :item_total, :total, :state,
    :adjustment_total, :user_id, :created_at, :updated_at, :completed_at,
    :payment_total, :shipment_state, :payment_state, :email,
    :special_instructions, :token, :line_items
end
