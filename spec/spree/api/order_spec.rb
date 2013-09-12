describe Spree::API::Order do
  before do
    @klass = Spree::Order
    @object = @klass.instance
  end

  describe ".advance_current_order" do
    before do
      disable_network_access!

      Spree.authentication_endpoint = "http://spree.store.com/user/sign_in"
      Spree.token = "A-SECRET"
      Spree.cookie = "A-COOKIE"
    end

    after do
      enable_network_access!
    end

    describe "when state is 'cart'" do
      before do
        Spree::Order.instance.state

        Spree::Order.instance.state = "cart"

        @request = {
          body: Spree::Order.instance.to_json,
          headers: {
            "Accept"        => "application/json",
            "Content-Type"  => "application/json",
            "Cookie"        => Spree.cookie,
            "X-Spree-Token" => Spree.token
          }
        }

        @response = {
          body: BW::JSON.generate(Fixtures::Order.in_address_state),
          headers: {
            "Content-Type"  => "application/json",
            "Set-Cookie"    => "A-COOKIE"
          }
        }

        stub_request(:put, Spree.checkout_next_state_uri).with(@request).to_return(@response)
      end

      it "sets the state of the order to 'address'" do
        Spree.advance_current_order do |json, response|
          resume
        end

        wait_max 1.0 do
          Spree::Order.instance.state.should.equal "address"
        end
      end
    end

    describe "when there's an error" do
      before do
        Spree::Order.instance.state

        Spree::Order.instance.state = "address"

        @request = {
          body: Spree::Order.instance.to_json,
          headers: {
            "Accept"        => "application/json",
            "Content-Type"  => "application/json",
            "Cookie"        => Spree.cookie,
            "X-Spree-Token" => Spree.token
          }
        }

        @response = {
          body: BW::JSON.generate({
            error: "The order could not be transitioned. Please fix the errors and try again.",
            errors: {
              bill_address_attributes: {
                address1: [
                  "can't be blank"
                ]
              }
            }
          }),
          headers: {
            "Content-Type"  => "application/json",
            "Set-Cookie"    => "A-COOKIE"
          }
        }

        stub_request(:put, Spree.checkout_next_state_uri).with(@request).to_return(@response)
      end

      it "sets the state of the order to 'address'" do
        @errors = nil
        Spree.advance_current_order do |json, response|
          @errors = json[:errors]
          resume
        end

        wait_max 1.0 do
          @errors[:bill_address_attributes][:address1].first.should.equal "can't be blank"
        end
      end
    end

  end
end
