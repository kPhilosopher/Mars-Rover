#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'Grid'

class TestGrid
	include Test::Unit::Assertions

	def test_initialize
		grid = Grid.new
		assert_equal :unoccupied, grid.state

		# ----------------------------------------------------------

		grid = Grid.new(:occupied)
		assert_equal :occupied, grid.state
	end

	def test_set_state
		grid = Grid.new
		assert_equal :unoccupied, grid.state

		assert_equal true, grid.set_state(:occupied)

		assert_equal :occupied, grid.state
	end

	def test_set_wrong_state
		grid = Grid.new
		assert_equal :unoccupied, grid.state

		assert_equal false, grid.set_state(:blaaa)

		assert_equal :unoccupied, grid.state
	end
end

# ------------------------------------------------------------------

grid_tester = TestGrid.new
grid_tester.test_initialize
grid_tester.test_set_state
grid_tester.test_set_wrong_state

