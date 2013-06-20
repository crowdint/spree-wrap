describe Spree::API::Product do
  #
  # Legacy tests, now work as semi-integration tests
  #
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
end
