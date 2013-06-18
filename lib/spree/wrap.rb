require "spree/wrap/version"
require "motion-support/concern"
require "motion-support/inflector"

#
# Models
#
BubbleWrap.require 'motion/spree/model.rb'
BubbleWrap.require 'motion/spree/product.rb'

#
# API Queries
#
BubbleWrap.require 'motion/spree/api/query.rb'
BubbleWrap.require 'motion/spree/api/product.rb'

#
# Main Module
#
BubbleWrap.require 'motion/spree.rb'
