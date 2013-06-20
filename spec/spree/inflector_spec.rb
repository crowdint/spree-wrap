describe Spree::Inflector do
  describe ".pluralize" do
    it "adds an s to the end of the specified singular" do
      Spree::Inflector.pluralize("cat").should == "cats"
    end
  end
end
