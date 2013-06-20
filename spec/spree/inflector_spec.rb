describe Spree::Inflector do
  describe ".pluralize" do
    describe "defined Inflection" do
      it "adds an s to the end of the specified singular" do
        Spree::Inflector.pluralize("cat").should == "cats"
      end

      it "pluralizes country" do
        Spree::Inflector.pluralize("country").should == "countries"
      end
    end

    describe "undefined Inflection" do
      it "raises Spree::Inflector::UndefinedInflection" do
        lambda {
          Spree::Inflector.pluralize("42")
        }.should.raise(Spree::Inflector::UndefinedInflection)
      end
    end
  end

  describe ".inflections" do
    it "defines a new inflection" do
      Spree::Inflector.inflection 'foo', 'bar'
      Spree::Inflector.pluralize('foo').should == 'bar'
    end
  end
end
