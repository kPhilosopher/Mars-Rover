#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'Rover'
require 'Plateau'

class TestRover
	include Test::Unit::Assertions

	def test_initialized_rover
		rover = Rover.new(nil, nil)
		assert_equal Rover, rover.class
	end

	def test_current_coordinate
		rover = Rover.new(nil, nil)
		assert_equal nil, rover.start_coordinate
		assert_equal nil, rover.start_direction
		# assert_equal Coordinate.new.x, rover.start_coordinate.x
		# assert_equal Coordinate.new.y, rover.start_coordinate.y

		# ----------------------------------------------------------

		rover = Rover.new(Coordinate.new(10,2), nil)
		assert_equal Coordinate.new(10,2).x, rover.start_coordinate.x
		assert_equal Coordinate.new(10,2).y, rover.start_coordinate.y
		assert_equal nil, rover.start_direction
	end

	def test_facing_direction
		rover = Rover.new(nil, "S")
		assert_equal "S", rover.start_direction
	end

	def test_deploy
		coordinate = Coordinate.new(3, 2)
		rover = Rover.new(coordinate, "N")
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = Plateau.new(maximum_coordinate)
		rover.deploy(plateau)
	end
end

# ------------------------------------------------------------------
rover_tester = TestRover.new
rover_tester.test_initialized_rover
rover_tester.test_current_coordinate
rover_tester.test_facing_direction
