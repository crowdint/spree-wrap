describe Spree::API::LineItem do

  describe "URI methods" do
    before do
      @previous_endpoint      = Spree.endpoint
      @previous_order_number  = Spree.order_number
      @previous_cookie        = Spree.cookie
      @previous_token         = Spree.token
      Spree.endpoint          = "http://spree.store.com/api"
      Spree.order_number      = "12345"
      Spree.cookie            = "FooBarishCookie"
      Spree.token             = "FooBarishToken"
    end

    after do
      Spree.endpoint      = @previous_endpoint
      Spree.order_number  = @previous_order_number
      Spree.cookie        = @previous_cookie
      Spree.token         = @previous_token
    end

    describe ".line_items_uri" do
      it "returns a proper uri" do
        expected = "http://spree.store.com/api/orders/12345/line_items"
        Spree.line_items_uri.should.equal(expected)
      end
    end

    describe ".line_item_uri" do
      it "returns a proper uri" do
        expected = "http://spree.store.com/api/orders/12345/line_items/23"
        Spree.line_item_uri(23).should.equal(expected)
      end
    end
  end

  describe ".create_line_item" do
    before do
      disable_network_access!

      @previous_endpoint      = Spree.endpoint
      @previous_order_number  = Spree.order_number
      @previous_cookie        = Spree.cookie
      @previous_token         = Spree.token
      Spree.endpoint          = "http://spree.store.com/api"
      Spree.order_number      = "12345"
      Spree.cookie            = "FooBarishCookie"
      Spree.token             = "FooBarishToken"
    end

    after do
      enable_network_access!

      Spree.endpoint      = @previous_endpoint
      Spree.order_number  = @previous_order_number
      Spree.cookie        = @previous_cookie
      Spree.token         = @previous_token
    end


    describe "with valid attributes" do
      describe "creating a line_item" do
        before do
          @payload = BW::JSON.generate({
            line_item: {
              variant_id:   1,
              quantity:     1
            }
          })

          @request_headers = {
            "Accept"        => "application/json",
            "Content-Type"  => "application/json",
            "Cookie"        => Spree.cookie,
            "X-Spree-Token" => Spree.token
          }

          @request = {
            body:     @payload,
            headers:  @request_headers
          }

          @data = BW::JSON.generate({
            id:         1,
            quantity:   1,
            price:      200,
            variant_id: 1,
            variant: {
              id:     1,
              name:   "Rails"
            }
          })

          @response_headers = {
            "Content-Type"  => "application/json",
            "Set-Cookie"    => "FooBarishCookie"
          }

          @status_code = 201

          @response = {
            body:         @data,
            headers:      @response_headers,
            status_code:  @status_code
          }

          stub_request(:post, Spree.line_items_uri).with(@request).to_return(@response)
        end

        it "creates a line_item with variant id equal to 1" do
          @line_item = nil
          Spree.create_line_item(variant_id: 1, quantity: 1) do |line_item, response|
            @line_item = line_item
            resume
          end

          wait_max 1.0 do
            @line_item.variant_id.should.equal(1)
          end
        end

        it "should get a 201 response from the remote source" do
          @returned_status_code = nil
          Spree.create_line_item(variant_id: 1, quantity: 1) do |line_item, response|
            @returned_status_code = response.status_code
            resume
          end

          wait_max 1.0 do
            @returned_status_code.should.equal(201)
          end
        end

        it "fooos around" do
          stub_request(:post, "http://example.net/foo").
            with(body: '{"foo": "bar"}', headers: {"Content-Type" => "application/json"}).
            to_return(body: '{"foo": "bar"}', headers: {"Content-Type" => "application/json"}, status_code: 201)

          BW::HTTP.post("http://example.net/foo", {payload: '{"foo": "bar"}', headers: {"Content-Type" => "application/json"}}) do |response|
            @returned_status_code = response.status_code
            @returned_json = BW::JSON.parse(response.body)
            resume
          end

          wait_max 1.0 do
            @returned_status_code.should.equal(201)
          end
        end
      end
    end
  end

  describe ".headers" do
    before do
      @previous_endpoint      = Spree.endpoint
      @previous_order_number  = Spree.order_number
      @previous_cookie        = Spree.cookie
      @previous_token         = Spree.token
      Spree.endpoint          = "http://spree.store.com/api"
      Spree.order_number      = "12345"
      Spree.cookie            = "FooBarishCookie"
      Spree.token             = "FooBarishToken"

      @result = Spree.send(:line_items_request, variant_id: 1, quantity: 1)
    end

    after do
      Spree.endpoint      = @previous_endpoint
      Spree.order_number  = @previous_order_number
      Spree.cookie        = @previous_cookie
      Spree.token         = @previous_token
    end

    it "returns a hash" do
      @result.class.should.equal(Hash)
    end

    it "returns a hash in the :headers key" do
      @result[:headers].class.should.equal(Hash)
    end

    it "sets the Accept header to application/json" do
      @result[:headers]["Accept"].should.equal("application/json")
    end

    it "sets the Cookie header to the current Spree.cookie" do
      @result[:headers]["Cookie"].should.equal("FooBarishCookie")
    end

    it "sets the X-Spree-Token header to the current Spree.token" do
      @result[:headers]["X-Spree-Token"].should.equal("FooBarishToken")
    end
  end
end
