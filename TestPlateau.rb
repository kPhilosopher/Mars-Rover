#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'Plateau'

class TestPlateau
	include Test::Unit::Assertions
	
	def test_initialization
		plateau = Plateau.new(nil)
		assert_equal Plateau, plateau.class
		assert_equal nil, plateau.maximum_coordinate
	end

	def test_initialization_with_given_maximum_coordinate
		given_coordinate = Coordinate.new(2,3)
		plateau = Plateau.new(given_coordinate)
		assert_equal given_coordinate.x, plateau.maximum_coordinate.x
		assert_equal given_coordinate.y, plateau.maximum_coordinate.y
	end
end

# ------------------------------------------------------------------

plateau_tester = TestPlateau.new
plateau_tester.test_initialization
plateau_tester.test_initialization_with_given_maximum_coordinate