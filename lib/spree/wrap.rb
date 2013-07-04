require "spree/wrap/version"
require "bubble-wrap"
require "motion-support/concern"

BubbleWrap.require 'motion/spree/inflector.rb'

#
# Models
#
BubbleWrap.require 'motion/spree/model.rb'
BubbleWrap.require 'motion/spree/country.rb'
BubbleWrap.require 'motion/spree/product.rb'
BubbleWrap.require 'motion/spree/product_property.rb'
BubbleWrap.require 'motion/spree/taxonomy.rb'
BubbleWrap.require 'motion/spree/variant.rb'
BubbleWrap.require 'motion/spree/zone.rb'

#
# API Queries
#
BubbleWrap.require 'motion/spree/api/resource_name.rb'
BubbleWrap.require 'motion/spree/api/query.rb'
BubbleWrap.require 'motion/spree/api/uri.rb'
BubbleWrap.require 'motion/spree/api/country.rb'
BubbleWrap.require 'motion/spree/api/product.rb'
BubbleWrap.require 'motion/spree/api/product_property.rb'
BubbleWrap.require 'motion/spree/api/taxonomy.rb'
BubbleWrap.require 'motion/spree/api/variant.rb'
BubbleWrap.require 'motion/spree/api/zone.rb'

#
# Main Module
#
BubbleWrap.require 'motion/spree.rb'
