# Spree-Wrap

[![Build Status](https://travis-ci.org/crowdint/spree-wrap.png?branch=master)](https://travis-ci.org/crowdint/spree-wrap)

Consume any compatible Spree API from Ruby Motion

## Installation

Add this line to your application's Gemfile:

    gem 'spree-wrap'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spree-wrap

## Usage

Within your application delegate or before accessing the API set the url to the endpoint.

    Spree.endpoint = "http://example.com/api"

You can now query the API by using blocks.

Example:

    Spree.products do |products|
      # Do something when products are received
    end

## Authentication

Within your application delegate or before accessing the Authentication
API, set the url to the authentication and registration endpoint.

    Spree.authentication_endpoint = "http://example.com/users/sign_in"

Then you need to create an instance of the User Model to store user's credentials.

    user = Spree::User.new({
      "email"     => "example@mail.com",
      "password"  => "somepassword"
    })

Now you can send the authentication request.

    Auth.authenticate!(user) do |response|
      if response.ok?
        Auth.current_user     # => #<Spree::User:0xc195950>
        App.alert("Successfully authenticated!")
      else
        Auth.current_user     # => nil
        App.alert("Something went terribly wrong")
      end
    end

You can use the `response` object to know exactly which status code was
returned by the server in order to provide feedback about what caused an
error with `response.status_code`

###Registration

Registering new users can be easily achieved by setting a
`Spree.registration_endpoint` and an instance of `Spree::User` with
`email`, `password`, and `password_confirmation`.

    Spree.registration_endpoint = "http://example.com/users"

    user = Spree::User.new({
      "email"                   => "example@mail.com",
      "password"                => "somepassword",
      "password_confirmation"   => "somepassword"
    })

    Auth.register!(user) do |response|
      if response.ok?
        Auth.current_user     # => #<Spree::User:0xc195950>
        App.alert("Successfully registered!")
      else
        Auth.current_user     # => nil
        App.alert("Something went terribly wrong")
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development company that happens to work in Colima, Mexico.
We specialize in building and growing online retail stores. We don’t work with everyone – just companies we believe in. Call us today to see if there’s a fit.
Find more info [here](http://www.crowdint.com)!
