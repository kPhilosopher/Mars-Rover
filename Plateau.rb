#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'Coordinate'

class Plateau
	attr_reader :maximum_coordinate

	def initialize(maximum_coordinate = Coordinate.new(0,0))
		@maximum_coordinate = maximum_coordinate
		setup
	end

	private

	def setup

	end

	public 

	def state_at_coordinate(coordinate)

	end

	def set_state_at_coordinate(new_state, coordinate)

	end

	def grid_at_coordinate(coordinate)

	end
end