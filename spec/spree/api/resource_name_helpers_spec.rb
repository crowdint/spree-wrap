module Foo
  class Cat
    extend Spree::API::ResourceNameHelpers
  end
end

describe Spree::API::ResourceNameHelpers do
  it "defines the resource_name method" do
    Foo::Cat.resource_name.should == "cat"
  end

  it "defines the resource_name_plural method" do
    Foo::Cat.resource_name_plural.should == "cats"
  end
end
