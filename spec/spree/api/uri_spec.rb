Spree::Inflector.inflection 'animal', 'animals'

module Animal
  extend Spree::API::ResourceName
  include Spree::API::URI
end

class Dog
  extend Animal
end

describe Spree::API::URI do
  describe ".resources_uri" do
    it "builds a resource collection URI" do
      Dog.animals_uri.should == "http://example.com/api/animals"
    end
  end

  describe ".resource_uri" do
    it "builds a single resource URI" do
      Dog.animal_uri(1).should == "http://example.com/api/animals/1"
    end
  end
end
