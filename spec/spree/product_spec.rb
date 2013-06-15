describe Spree::Product do
  describe ".all" do
    it "returns an Enumerable" do
      Spree::Product.all.is_a?(Enumerable).should == true
    end
  end
end
