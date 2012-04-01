#!/usr/bin/ruby

class Coordinate
	attr_accessor :x
	attr_accessor :y

	def initialize(x_value = -1, y_value = -1)
		@x = x_value
		@y = y_value
	end
end
