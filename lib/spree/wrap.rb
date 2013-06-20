require "spree/wrap/version"
require "motion-support/concern"

BubbleWrap.require 'motion/spree/inflector.rb'

#
# Models
#
BubbleWrap.require 'motion/spree/model.rb'
BubbleWrap.require 'motion/spree/product.rb'

#
# API Queries
#
BubbleWrap.require 'motion/spree/api/resource_name_helpers.rb'
BubbleWrap.require 'motion/spree/api/query.rb'
BubbleWrap.require 'motion/spree/api/uri_helpers.rb'
BubbleWrap.require 'motion/spree/api/product.rb'

#
# Main Module
#
BubbleWrap.require 'motion/spree.rb'
