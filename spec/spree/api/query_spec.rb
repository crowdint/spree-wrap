module Spree
  class Foo
    include Spree::Model

    define_model_attributes :id, :name
  end

  module API
    class Foo
      extend Spree::API::Query
    end
  end
end

describe Spree::API::Query do
  extend WebStub::SpecHelpers

  before do
    disable_network_access!
    Spree.token = "A-SECRET"
  end

  describe "#collection_query" do
    before do
      @uri = "http://example.com/api/foos"
      @data = { foos: [{ id: "1", name: "Foo 1" }, { id: "2", name: "Foo 2" }] }
      stub_request(:get, @uri).
          with(headers: { "X-Spree-Token" => Spree.token }).
          to_return(json: @data)

      Spree::API::Foo.collection_query("foos", Spree::Foo, @uri) do |f|
        @foos = f
        resume
      end

      # Wait for the BW::HTTP Thread
      wait_max 1 { @foos }
    end

    it "maps received data to objects of the specified class" do
      @foos.each_with_index do |f, i|
        f.is_a?(Spree::Foo).should.be.true
        f.id.should.equal   @data[:foos][i][:id]
        f.name.should.equal @data[:foos][i][:name]
      end
    end
  end

  describe "#object_query" do
    before do
      @uri = "http://example.com/api/foos/1"
      @data = { id: "1", name: "Foo 1" }
      stub_request(:get, @uri).
          with(headers: { "X-Spree-Token" => Spree.token }).
          to_return(json: @data)

      Spree::API::Foo.object_query(Spree::Foo, @uri) do |f|
        @foo = f
        resume
      end

      # Wait for the BW::HTTP Thread
      wait_max 1 { @foo }
    end

    it "maps received data to an object of the specified class" do
      @foo.is_a?(Spree::Foo).should.be.true
      @foo.id.should.equal   @data[:id]
      @foo.name.should.equal @data[:name]
    end
  end
end
