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

        it "creates a line_item with an id equal to 1" do
          @line_item = nil
          Spree.create_line_item(variant_id: 1, quantity: 1) do |line_item, response|
            @line_item = line_item
            resume
          end

          wait_max 1.0 do
            @line_item.id.should.equal(1)
          end
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
      end
    end
  end

  describe ".update_line_item" do
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
              quantity:     4
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
            quantity:   4,
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

          @status_code = 200

          @response = {
            body:         @data,
            headers:      @response_headers,
            status_code:  @status_code
          }

          stub_request(:put, Spree.line_item_uri(1)).with(@request).to_return(@response)
        end

        it "updates the line_item with id 1" do
          @line_item = nil
          Spree.update_line_item(id: 1, variant_id: 1, quantity: 4) do |line_item, response|
            @line_item = line_item
            resume
          end

          wait_max 1.0 do
            @line_item.id.should.equal(1)
          end
        end

        it "updates the line_item's quantity to 4" do
          @line_item = nil
          Spree.update_line_item(id: 1, variant_id: 1, quantity: 4) do |line_item, response|
            @line_item = line_item
            resume
          end

          wait_max 1.0 do
            @line_item.quantity.should.equal(4)
          end
        end

        it "should get a 200 response from the remote source" do
          @returned_status_code = nil
          Spree.update_line_item(id: 1, variant_id: 1, quantity: 4) do |line_item, response|
            @returned_status_code = response.status_code
            resume
          end

          wait_max 1.0 do
            @returned_status_code.should.equal(200)
          end
        end
      end
    end
  end

  describe ".delete_line_item" do
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

    describe "deleting an item" do
      before do
        @request_headers = {
          "Accept"        => "application/json",
          "Content-Type"  => "application/json",
          "Cookie"        => Spree.cookie,
          "X-Spree-Token" => Spree.token
        }

        @request = {
          body:     nil,
          headers:  @request_headers
        }

        @response_headers = {
          "Content-Type"  => "application/json",
          "Set-Cookie"    => "FooBarishCookie"
        }

        @status_code = 204

        @response = {
          body:         "",
          headers:      @response_headers,
          status_code:  @status_code
        }

        stub_request(:delete, Spree.line_item_uri(1)).with(@request).to_return(@response)
      end

      it "returns a 204 response" do
        @returned_status_code = nil
        Spree.delete_line_item(1) do |response|
          @returned_status_code = response.status_code
          resume
        end

        wait_max 1.0 do
          @returned_status_code.should.equal(204)
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

      @result = Spree.send(:create_line_item_request, variant_id: 1, quantity: 1)
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
