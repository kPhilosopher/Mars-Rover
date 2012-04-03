#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'GridPlateau'
require 'GridStates'

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

		assert_equal given_coordinate.x+1, plateau.grids.size
		assert_equal given_coordinate.y+1, plateau.grids[0].size
		assert_equal Grid, plateau.grids[0][0].class
	end

	def test_state_at_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)
		coordinate_to_check = Coordinate.new(1, 1)
		state = plateau.state_at_coordinate(coordinate_to_check)
		assert_equal GridStates::DefinedStates[1], state
	end

	def test_state_at_coordinate_outside_maximum_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)
		coordinate_to_check = Coordinate.new(8, 1)
		state = plateau.state_at_coordinate(coordinate_to_check)
		assert_equal GridStates::DefinedStates[2], state
	end  

	def test_state_at_coordinate_with_negative_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)
		coordinate_to_check = Coordinate.new(8, -1)
		state = plateau.state_at_coordinate(coordinate_to_check)
		assert_equal GridStates::DefinedStates[2], state
	end  

	def test_set_state_at_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)

		coordinate = Coordinate.new(2, 2)
		state = plateau.state_at_coordinate(coordinate)
		assert_equal GridStates::DefinedStates[1], state

		assert_equal true, plateau.set_state_at_coordinate(GridStates::DefinedStates[0], coordinate)
		
		assert_equal GridStates::DefinedStates[0], plateau.grid_at_coordinate(coordinate).state
	end

	def test_set_state_at_coordinate_outside_maximum_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)

		coordinate = Coordinate.new(2, 9)
		state = plateau.state_at_coordinate(coordinate)
		assert_equal GridStates::DefinedStates[2], state

		assert_equal false, plateau.set_state_at_coordinate(GridStates::DefinedStates[0], coordinate)
	end

	def test_set_state_at_coordinate_with_negative_coordinate
		given_coordinate = Coordinate.new(2, 3)
		plateau = GridPlateau.new(given_coordinate)

		coordinate = Coordinate.new(2, -2)
		state = plateau.state_at_coordinate(coordinate)
		assert_equal GridStates::DefinedStates[2], state

		assert_equal false, plateau.set_state_at_coordinate(GridStates::DefinedStates[0], coordinate)
	end
end

# ------------------------------------------------------------------

plateau_tester = TestGridPlateau.new
plateau_tester.test_initialization
plateau_tester.test_initialization_with_given_maximum_coordinate
plateau_tester.test_state_at_coordinate
plateau_tester.test_state_at_coordinate_outside_maximum_coordinate
plateau_tester.test_state_at_coordinate_with_negative_coordinate
plateau_tester.test_set_state_at_coordinate
plateau_tester.test_set_state_at_coordinate_outside_maximum_coordinate
plateau_tester.test_set_state_at_coordinate_with_negative_coordinate
