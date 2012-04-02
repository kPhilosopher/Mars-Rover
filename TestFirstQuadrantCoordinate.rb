#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/31/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'

require 'FirstQuadrantCoordinate'

class TestFirstQuadrantCoordinate
	include Test::Unit::Assertions

	def test_coordinate_initialized
		coordinate = FirstQuadrantCoordinate.new(10, 20)
		assert_equal 10, coordinate.x
		assert_equal 20, coordinate.y
	end

	def test_coordinate_initialized_with_no_coordinates
		coordinate = FirstQuadrantCoordinate.new
		assert_equal 0, coordinate.x
		assert_equal 0, coordinate.y
	end

	def test_coordinate_initialized_with_negative_coordinates
		coordinate = FirstQuadrantCoordinate.new(3,-5)
		assert_equal 3, coordinate.x
		assert_equal 0, coordinate.y
	end

	def test_coordinate_set_coordinates
		coordinate = FirstQuadrantCoordinate.new(10, 20)
		assert_equal 10, coordinate.x
		assert_equal 20, coordinate.y

		coordinate.x = 100
		coordinate.y = 300

		assert_equal 100, coordinate.x
		assert_equal 300, coordinate.y
	end
end


# ------------------------------------------------------------------

coordinate_tester = TestFirstQuadrantCoordinate.new
coordinate_tester.test_coordinate_initialized
coordinate_tester.test_coordinate_initialized_with_no_coordinates
coordinate_tester.test_coordinate_initialized_with_negative_coordinates
coordinate_tester.test_coordinate_set_coordinates

