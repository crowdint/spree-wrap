class Fixtures
  class Order
    def self.create(values)
      {
        id:                 1,
        number:             "R335381310",
        item_total:         "100.0",
        display_item_total: "$100.00",
        total:              "100.0",
        display_total:      "$100.00",
        state:              "cart",
        adjustment_total:   "-12.0",
        total_quantity:     1,
        token:              "abcdef123456",
        line_items: [
          {
            id:               1,
            quantity:         2,
            price:            "19.99",
            total:            "39.99",
            display_total:    "$39.99",
            variant_id:       1,
            variant: {
              id:               1,
              name:             "Ruby on Rails Tote",
              count_on_hand:    10,
              price:            "15.99",
              is_master:        true,
              option_values: [
                {
                  id:             1,
                  name:           "Small",
                }
              ],
              images: [
                {
                  id:                       1,
                  attachment_content_type:  "image/jpg",
                  type:                     "Spree::Image",
                  attachment_width:         360,
                  attachment_height:        360,
                }
              ],
              description:      "A text description of the product.",
              options_text:     "(Size: small, Colour: red)"
            }
          }
        ]
      }.merge(values)
    end

    def self.in_cart_state
      create(state: "cart")
    end

    def self.in_address_state
      create(state: "address")
    end

    def self.in_delivery_state
      create(state: "delivery")
    end

    def self.in_payment_state
      create(state: "payment")
    end

    def self.in_confirm_state
      create(state: "confirm")
    end

    def self.in_complete_state
      create(state: "complete")
    end
  end
end
