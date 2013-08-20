describe Spree::Auth do
  before do
    @subject = Spree::Auth
  end

  describe "current_user" do
    it "exists" do
      @subject.respond_to?(:current_user).should.be.true
    end
  end

  describe "credentials" do

  end

  describe "default_headers" do
    it "always returns a hash" do
      @subject.instance_eval{@default_headers = nil}
      @subject.default_headers.class.should.equal(Hash)
    end

    it "returns the Content-Type" do
      @subject.default_headers["Content-Type"].should.not.be.nil
    end

    it "returns a Content-Type equal to application/json" do
      @subject.default_headers["Content-Type"].should.equal("application/json")
    end
  end

  describe "payload generators" do
    before do
      test_user = Spree::User.new({
        "email"                 => "foo@bar.com",
        "password"              => "FizzBuzz",
        "password_confirmation" => "FizzBuzz"
      })
      @subject.instance_eval{ @current_user = test_user }
    end

    after do
      @subject.instance_eval{ @current_user = nil }
    end

    describe "credentials" do
      it "returns a string" do
        @subject.credentials.class.should.equal(String)
      end

      it "returns a specfic JSON structure" do
        expected = '{"spree_user":{"email":"foo@bar.com","password":"FizzBuzz"}}'
        @subject.credentials.should.equal(expected)
      end

      it "contains the user's email" do
        @subject.credentials.should.match(/foo@bar\.com/)
      end

      it "contains the user's password" do
        @subject.credentials.should.match(/FizzBuzz/)
      end
    end

    describe "new_user_data" do
      it "returns a string" do
        @subject.new_user_data.class.should.equal(String)
      end

      it "contains the user's email" do
        @subject.new_user_data.should.match(/"email":"foo@bar\.com"/)
      end

      it "contains the user's password" do
        @subject.new_user_data.should.match(/"password":"FizzBuzz"/)
      end

      it "contains the user's password_confirmation" do
        @subject.new_user_data.should.match(/"password_confirmation":"FizzBuzz"/)
      end
    end
  end

  describe "requests" do
    before do
      test_user = Spree::User.new({
        "email"                 => "foo@bar.com",
        "password"              => "FizzBuzz",
        "password_confirmation" => "FizzBuzz"
      })
      @subject.instance_eval{ @current_user = test_user }
    end

    after do
      @subject.instance_eval{ @current_user = nil }
    end

    describe "authentication_request" do
      it "returns a Hash" do
        @subject.authentication_request.class.should.equal(Hash)
      end

      it "returns a Hash in the headers key" do
        @subject.authentication_request[:headers].class.should.equal(Hash)
      end

      it "returns a String in the payload key" do
        @subject.authentication_request[:payload].class.should.equal(String)
      end

      it "returns the user's credentials as the payload" do
        @subject.authentication_request[:payload].should.equal(@subject.credentials)
      end
    end

    describe "registration_request" do
      it "returns a Hash" do
        @subject.registration_request.class.should.equal(Hash)
      end

      it "returns a Hash in the headers key" do
        @subject.registration_request[:headers].class.should.equal(Hash)
      end

      it "returns a String in the payload key" do
        @subject.registration_request[:payload].class.should.equal(String)
      end

      it "returns the user's registration data as the payload" do
        @subject.registration_request[:payload].should.equal(@subject.new_user_data)
      end
    end
  end

  describe "authenticate!" do
    before do
      disable_network_access!
      Spree.authentication_endpoint = "http://spree.store.com/user/sign_in"
      Spree.token = nil
      Spree.cookie = nil

      @user = Spree::User.new({
        "email"     => "foo@bar.com",
        "password"  => "FizzBuzz",
      })
      @payload = BW::JSON.generate(
        spree_user: {
          email: @user.email,
          password: @user.password
        }
      )
      @request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
    end

    after do
      @user               = nil
      @data               = nil
      @payload            = nil
      @response_headers   = nil
      @request_headers    = nil
      @status_code        = nil

      reset_stubs

      enable_network_access!
    end

    describe "with valid credentials" do
      before do
        @data = BW::JSON.generate({
          "email"         => @user.email,
          "password"      => @user.password,
          "spree_api_key" => "FooBarishToken"
        })
        @response_headers = {
          "Set-Cookie" => "FooBarishCookie",
        }
        @status_code = 200
        stub_request(:post, Spree.authentication_endpoint).
          with(body: @payload, headers: @request_headers).
          to_return(body: @data, headers: @response_headers, status_code: @status_code)
      end

      it "returns a status code of 200" do
        @status_code = nil
        @subject.authenticate!(@user) do |response|
          @status_code = response.status_code
          resume
        end

        wait_max 2.0 do
          @status_code.should.equal(200)
        end
      end

      it "sets the Spree token" do
        @subject.authenticate!(@user){ |response| resume }

        wait_max 1.0 do
          Spree.token.should.equal("FooBarishToken")
        end
      end

      it "sets the cookie" do
        @subject.authenticate!(@user){ |response| resume }

        wait_max 1.0 do
          Spree.cookie.should.equal("FooBarishCookie")
        end
      end
    end

    describe "with invalid credentials" do
      before do
        @data = BW::JSON.generate({
          "error" => "Invalid email or password."
        })
        @response_headers = {}
        @status_code = 401
        stub_request(:post, Spree.authentication_endpoint).
          with(body: @payload, headers: @request_headers).
          to_return(body: @data, headers: @response_headers, status_code: @status_code)
      end

      it "returns a status code of 401" do
        @status_code = nil
        @subject.authenticate!(@user) do |response|
          @status_code = response.status_code
          resume
        end

        wait_max 1.0 do
          @status_code.should.equal(401)
        end
      end

      it "returns an error key in the response body" do
        @json = nil
        @subject.authenticate!(@user) do |response|
          @json = BW::JSON.parse(response.body.to_str)
          resume
        end

        wait_max 1.0 do
          @json.class.should.equal(Hash)
          @json["error"].class.should.equal(String)
        end
      end
    end
  end

  describe "register!" do
    before do
      disable_network_access!
      Spree.registration_endpoint = "http://spree.store.com/user"
      Spree.token = nil
      Spree.cookie = nil

      @user = Spree::User.new({
        "email"                   => "foo@bar.com",
        "password"                => "FizzBuzz",
        "password_confirmation"   => "FizzBuzz",
      })
      @payload = BW::JSON.generate(
        spree_user: {
          email:                  @user.email,
          password:               @user.password,
          password_confirmation:  @user.password
        }
      )
      @request_headers = {
        "Accept"        => "application/json",
        "Content-Type"  => "application/json"
      }
    end

    after do
      @user               = nil
      @data               = nil
      @payload            = nil
      @response_headers   = nil
      @request_headers    = nil
      @status_code        = nil

      reset_stubs

      enable_network_access!
    end

    describe "with valid credentials" do
      before do
        @data = BW::JSON.generate({
          "email"         => @user.email,
          "password"      => @user.password,
          "spree_api_key" => "FooBarishToken"
        })
        @response_headers = {
          "Set-Cookie" => "FooBarishCookie"
        }
        @status_code = 200
        stub_request(:post, Spree.registration_endpoint).
          with(body: @payload, headers: @request_headers).
          to_return(body: @data, headers: @response_headers, status_code: @status_code)
      end

      it "returns a status code of 200" do
        @status_code = nil
        @subject.register!(@user) do |response|
          @status_code = response.status_code
          resume
        end

        wait_max 1.0 do
          @status_code.should.equal(200)
        end
      end

      it "sets the Spree token" do
        @subject.register!(@user){ |response| resume }

        wait_max 1.0 do
          Spree.token.should.equal("FooBarishToken")
        end
      end

      it "sets the cookie" do
        @subject.register!(@user){ |response| resume }

        wait_max 1.0 do
          Spree.cookie.should.equal("FooBarishCookie")
        end
      end
    end

    describe "with invalid credentials" do
      before do
        @data = BW::JSON.generate({
          "error" => "Invalid email or password."
        })
        @response_headers = {}
        @status_code = 401
        stub_request(:post, Spree.registration_endpoint).
          with(body: @payload, headers: @request_headers).
          to_return(body: @data, headers: @response_headers, status_code: @status_code)
      end

      it "returns a status code of 401" do
        @status_code = nil
        @subject.register!(@user) do |response|
          @status_code = response.status_code
          resume
        end

        wait_max 1.0 do
          @status_code.should.equal(401)
        end
      end

      it "returns an error key in the response body" do
        @json = nil
        @subject.register!(@user) do |response|
          @json = BW::JSON.parse(response.body.to_str)
          resume
        end

        wait_max 1.0 do
          @json.class.should.equal(Hash)
          @json["error"].class.should.equal(String)
        end
      end
    end
  end
end
