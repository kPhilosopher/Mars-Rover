#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'GridPlateau'

class TestGridPlateau
	include Test::Unit::Assertions
	
	def test_initialization
		plateau = GridPlateau.new
		assert_equal GridPlateau, plateau.class

		assert_equal 0, plateau.maximum_coordinate.x
		assert_equal 0, plateau.maximum_coordinate.y
	end

	def test_initialization_with_given_maximum_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)
		assert_equal given_coordinate.x, plateau.maximum_coordinate.x
		assert_equal given_coordinate.y, plateau.maximum_coordinate.y

		assert_equal 3, plateau.grids.size
		assert_equal 4, plateau.grids[0].size
		assert_equal Grid, plateau.grids[0][0].class
	end

	def test_state_at_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)
		coordinate_to_check = Coordinate.new(1, 1)
		state = plateau.state_at(coordinate_to_check)
		assert_equal DefinedStates[1], state
	end

	def test_state_at_coordinate_outside_maximum_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)
		coordinate_to_check = Coordinate.new(8, 1)
		state = plateau.state_at(coordinate_to_check)
		assert_equal DefinedStates[1], state
	end
end

# ------------------------------------------------------------------

plateau_tester = TestGridPlateau.new
plateau_tester.test_initialization
plateau_tester.test_initialization_with_given_maximum_coordinate
plateau_tester.test_state_at_coordinate
plateau_tester.test_state_at_coordinate_outside_maximum_coordinate


