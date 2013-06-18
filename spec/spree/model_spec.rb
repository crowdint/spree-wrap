describe Spree::Model do
  before do
    @klass = Class.new
    @klass.send(:include, Spree::Model)
  end

  describe ".define_model_attributes" do
    before do
      @klass.define_model_attributes :id, :name
      @object = @klass.new("id" => 1, "name" => "Theodore")
    end

    it "creates the attribute list" do
      @object.attributes.should == [:id, :name]
    end

    it "creates accessors for all attributes" do
      [:id, :"id=", :name, :"name="].each do |accessor|
        @object.respond_to?(accessor).should == true
      end
    end

    it "loads declared attributes on .new" do
      @object.id.should   == 1
      @object.name.should == "Theodore"
    end
  end
end
