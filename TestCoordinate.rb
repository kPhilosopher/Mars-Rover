#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/31/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'

require 'Coordinate'

class TestCoordinate
	include Test::Unit::Assertions

	def test_coordinate_initialized
		coordinate = Coordinate.new(10, 20)
		assert_equal 10, coordinate.x
		assert_equal 20, coordinate.y
	end

	def test_coordinate_initialized_with_no_coordinates
		coordinate = Coordinate.new
		assert_equal -1, coordinate.x
		assert_equal -1, coordinate.y
	end

	def test_coordinate_set_coordinates
		coordinate = Coordinate.new(10, 20)
		assert_equal 10, coordinate.x
		assert_equal 20, coordinate.y

		coordinate.x = 100
		coordinate.y = 300

		assert_equal 100, coordinate.x
		assert_equal 300, coordinate.y
	end
end


# ------------------------------------------------------------------

coordinate_tester = TestCoordinate.new
coordinate_tester.test_coordinate_initialized
coordinate_tester.test_coordinate_initialized_with_no_coordinates
coordinate_tester.test_coordinate_set_coordinates

