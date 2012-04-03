#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/31/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

class Coordinate
	attr_accessor :x
	attr_accessor :y

	def initialize(x_value = 0, y_value = 0)
		@x = x_value
		@y = y_value
	end
end
