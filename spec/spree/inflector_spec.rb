describe Spree::Inflector do
  describe ".pluralize" do
    it "adds an s to the end of the specified singular" do
      Spree::Inflector.pluralize("cat").should == "cats"
    end
  end

  describe ".extract_resource_name" do
    it "extracts the resource name out of a Spree::xx module name" do
      Spree::Inflector.extract_resource_name("Spree::Product").should == "product"
    end
  end
end
