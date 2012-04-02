#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'CardinalDirections'
require 'Coordinate'

class Rover
	attr_reader :start_coordinate
	attr_reader :start_direction
	# attr_accessor :current_direction
	# attr_accessor :current_coordinate
	# attr_accessor :plateau

	def initialize(given_coordinate, given_direction)
		@start_coordinate = given_coordinate
		@start_direction = given_direction
	end



end