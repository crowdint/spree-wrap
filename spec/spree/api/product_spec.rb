describe Spree::API::Product do
  extend WebStub::SpecHelpers

  describe ".products_uri" do
    it "returns the endpoint path + the products path" do
      Spree.products_uri.should == Spree.endpoint + "/products"
    end
  end

  describe ".products" do
    before do
      disable_network_access!
      stub_request(:get, Spree.products_uri).
          to_return(json: load_webstub_response("products.json"))

      @products = nil
      Spree.products do |p|
        @products = p
        resume
      end

      wait_max 1 do
        @products
      end
    end

    it "returns an array of Spree::Product objects" do
      @products.all? { |p| p.is_a?(Spree::Product) }.should == true
    end
  end
end
