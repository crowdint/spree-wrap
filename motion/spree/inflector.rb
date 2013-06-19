module Spree
  #
  # This class should grow as needed to emulate ActiveSupport Inflections.
  #
  # Also, placeholder for other related helper methods.
  #
  # For now this is all we need.
  #
  class Inflector
    def self.pluralize(singular)
      "#{singular}s"
    end

    #
    #
    # Extracts the underscored resource name from the Module name
    #
    # Example, for Spree::Product it returns:
    #
    #   product
    #
    def self.extract_resource_name(class_name)
      (class_name =~ /(.+)::(.+)$/) ? $2.underscore : ""
    end
  end
end
