module Spree
  #
  # This class should grow as needed to emulate ActiveSupport Inflections.
  #
  # For now this is all we need
  #
  class Inflector
    def self.pluralize(singular)
      "#{singular}s"
    end
  end
end
