describe Spree::API::Product do
  describe ".products" do
    it "returns an Enumerable" do
      Spree.products.is_a?(Enumerable).should == true
    end
  end
end
