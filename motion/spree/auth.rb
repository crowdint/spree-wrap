class Spree::Auth
  class << self
    attr_reader :current_user
  end


  def self.authenticate!(user, &b)
    @current_user = user

    BW::HTTP.post(Spree.authentication_endpoint, authentication_request) do |response|
      if response.ok?
        store_current_user(response)
      else
        @current_user = nil
      end
      b.call(response)
    end
  end

  def self.register!(user, &b)
    @current_user = user

    BW::HTTP.post(Spree.registration_endpoint, registration_request) do |response|
      if response.ok?
        store_current_user(response)
      else
        @current_user = nil
      end
      b.call(response)
    end
  end

  def self.authentication_request
    { headers: default_headers, payload: credentials }
  end

  def self.registration_request
    { headers: default_headers, payload: new_user_data }
  end

  def self.default_headers
    @default_headers ||= {
      "Accept"        => "application/json",
      "Content-Type"  => "application/json"
    }
  end

  def self.credentials
    BW::JSON.generate({
      spree_user: {
        email:    current_user.email,
        password: current_user.password
      }
    })
  end

  def self.new_user_data
    BW::JSON.generate({
      spree_user: {
        email:                  current_user.email,
        password:               current_user.password,
        password_confirmation:  current_user.password_confirmation
      }
    })
  end

  def self.store_current_user(response)
    json = BW::JSON.parse(response.body)
    @current_user = Spree::User.new(json)
    Spree.token   = current_user.spree_api_key
    Spree.cookie  = response.headers["Set-Cookie"]
  end

end
