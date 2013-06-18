# Spree-Wrap

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
