describe Spree::API::Product do
  extend WebStub::SpecHelpers

  describe ".products_uri" do
    it "returns the complete URI for the list of products" do
      Spree.products_uri.should == Spree.endpoint + "/products"
    end
  end

  describe ".product_uri" do
    it "returns the complete URI for a product" do
      Spree.product_uri(1).should == Spree.products_uri + "/1"
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

  describe ".product" do
    before do
      disable_network_access!
      stub_request(:get, Spree.product_uri(1)).
          to_return(json: load_webstub_response("product.1.json"))

      @product = nil
      Spree.product(1) do |p|
        @product = p
        resume
      end

      wait_max 1 do
        @product
      end
    end

    it "returns a Spree::Product object" do
      @product.is_a?(Spree::Product).should == true
    end
  end
end
