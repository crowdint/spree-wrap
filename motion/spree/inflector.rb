module Spree
  #
  # Handles the pluralization of resource names for the API classes
  #
  class Inflector
    def self.inflections
      @inflections ||= []
    end

    def self.inflections=(value)
      @inflections = value
    end

    def self.pluralize(singular)
      inflection = self.inflections.detect { |i| i[:singular] == singular }
      raise UndefinedInflection unless inflection
      inflection[:plural]
    end

    def self.inflection(singular, plural)
      inflections << Inflection.new(singular, plural)
    end

    Inflection = Struct.new(:singular, :plural)

    class UndefinedInflection < Exception ; end
  end
end

Spree::Inflector.inflection 'cat', 'cats'
Spree::Inflector.inflection 'country', 'countries'
Spree::Inflector.inflection 'product', 'products'
Spree::Inflector.inflection 'taxonomy', 'taxonomies'
Spree::Inflector.inflection 'variant', 'variants'
