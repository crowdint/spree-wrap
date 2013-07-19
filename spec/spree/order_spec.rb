describe Spree::Order do
  before do
    @subject = Spree::Order
  end

  it "exists" do
    @subject.should.not.be.nil
  end

  describe ".fetch!" do
    before do
      disable_network_access!
      Spree.endpoint  = "https://spree.store.com/api"
      Spree.cookie    = "FooBarishCookie"

      @order = Spree::Order.new({
        "number"  => "R064275723",
        "token"   => "9057c89b50087307"
      })

      @response_headers = {
        "Content-Type" => "application/json"
      }
    end

    after do
      reset_stubs

      enable_network_access!
    end

    describe "with valid tokens" do
      before do
        Spree.token     = "123123123"

        @data = BW::JSON.generate({
          number: "R064275723",
          token:  "9057c89b50087307"
        })
        @status_code = 200

        stub_request(:get, "#{Spree.endpoint}/order").
          with(headers: @request_headers, body: @payload).
          to_return(headers: @response_headers, body: @data, status_code: @status_code)
      end

      it "sets the order token" do
        @subject.fetch! do |order, response|
          resume
        end

        wait_max 1.0 do
          Spree.order_token.should.equal(@order.token)
        end
      end

      it "gets an HTTP response of 200" do
        @subject.fetch! do |order, response|
          @response = response
          resume
        end

        wait_max 1.0 do
          @response.status_code.should.equal(200)
        end
      end
    end

    describe "with invalid tokens" do
      before do
        Spree.token     = "InvalidToken"
        @data = BW::JSON.generate({
          error: "You are not authorized to perform this action."
        })
        @status_code = 401

        stub_request(:get, "#{Spree.endpoint}/order").
          with(headers: @request_headers, body: @payload).
          to_return(headers: @response_headers, body: @data, status_code: @status_code)
      end

      it "gets an HTTP response of 401" do
        @subject.fetch! do |order, response|
          @response = response
          resume
        end

        wait_max 1.0 do
          @response.status_code.should.equal(401)
        end
      end
    end

  end

  describe ".instance" do
    before do
      @subject.instance_eval{@instance = nil}
    end

    it "always returns an instance of Spree::Order" do
      @subject.instance.class.should.equal(Spree::Order)
    end
  end
end
