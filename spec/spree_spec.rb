describe Spree do
  describe ".endpoint" do
    it "sets and gets the API endpoint" do
      Spree.endpoint         = "http://example.com"
      Spree.endpoint.should == "http://example.com"
    end
  end

  describe ".token" do
    it "sets and gets the Spree Token" do
      Spree.token         = "A-SECRET"
      Spree.token.should == "A-SECRET"
    end
  end
end
