#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/02/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'CardinalDirections'

class TestCardinalDirections
	include Test::Unit::Assertions
	
	def test_direction_when_rotated_left_with_direction_01
		current_direction = "E"
		assert_equal "N", CardinalDirections.direction_when_rotated_left_with_direction(current_direction)
	end

	def test_direction_when_rotated_left_with_direction_02
		current_direction = "S"
		assert_equal "E", CardinalDirections.direction_when_rotated_left_with_direction(current_direction)
	end

	def test_direction_when_rotated_left_with_direction_03
		current_direction = "W"
		assert_equal "S", CardinalDirections.direction_when_rotated_left_with_direction(current_direction)
	end

	def test_direction_when_rotated_left_with_direction_04
		current_direction = "N"
		assert_equal "W", CardinalDirections.direction_when_rotated_left_with_direction(current_direction)
	end

	def test_direction_when_rotated_right_with_direction_01
		current_direction = "E"
		assert_equal "S", CardinalDirections.direction_when_rotated_right_with_direction(current_direction)
	end

	def test_direction_when_rotated_right_with_direction_02
		current_direction = "S"
		assert_equal "W", CardinalDirections.direction_when_rotated_right_with_direction(current_direction)
	end

	def test_direction_when_rotated_right_with_direction_03
		current_direction = "W"
		assert_equal "N", CardinalDirections.direction_when_rotated_right_with_direction(current_direction)
	end

	def test_direction_when_rotated_right_with_direction_04
		current_direction = "N"
		assert_equal "E", CardinalDirections.direction_when_rotated_right_with_direction(current_direction)
	end
end

# ------------------------------------------------------------------

cardinal_directions_tester = TestCardinalDirections.new
cardinal_directions_tester.test_direction_when_rotated_left_with_direction_01
cardinal_directions_tester.test_direction_when_rotated_left_with_direction_02
cardinal_directions_tester.test_direction_when_rotated_left_with_direction_03
cardinal_directions_tester.test_direction_when_rotated_left_with_direction_04
cardinal_directions_tester.test_direction_when_rotated_right_with_direction_01
cardinal_directions_tester.test_direction_when_rotated_right_with_direction_02
cardinal_directions_tester.test_direction_when_rotated_right_with_direction_03
cardinal_directions_tester.test_direction_when_rotated_right_with_direction_04


