module Foo
  class Cat
    extend Spree::API::ResourceName
  end
end

describe Spree::API::ResourceName do
  it "defines the resource_name method" do
    Foo::Cat.resource_name.should == "cat"
  end

  it "defines the resource_name_plural method" do
    Foo::Cat.resource_name_plural.should == "cats"
  end
end
