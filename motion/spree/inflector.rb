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
      (singular == "country") ? "countries" : "#{singular}s"
    end
  end
end
