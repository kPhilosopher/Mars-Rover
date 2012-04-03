#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'Plateau'

class TestPlateau
	include Test::Unit::Assertions
	
	def test_initialization
		plateau = Plateau.new
		assert_equal Plateau, plateau.class

		assert_equal 0, plateau.maximum_coordinate.x
		assert_equal 0, plateau.maximum_coordinate.y
	end
end

# ------------------------------------------------------------------

plateau_tester = TestPlateau.new
plateau_tester.test_initialization