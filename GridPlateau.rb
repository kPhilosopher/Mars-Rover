#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'Plateau'
require 'Grid'
require 'GridStates'

class GridPlateau < Plateau

	attr_reader :grids

	private

	def setup
		@grids = []
		for x_index in 0..@maximum_coordinate.x
		   @grids[x_index] = []
		   for y_index in 0..@maximum_coordinate.y
		   		@grids[x_index][y_index] = Grid.new
		   end
		end
	end

	public

	def state_at_coordinate(coordinate)
		grid = grid_at_coordinate(coordinate)
		return GridStates::DefinedStates[2] if grid == nil
		return grid.state
	end

	def set_state_at_coordinate(new_state, coordinate)
		grid = grid_at_coordinate(coordinate)
		return false if grid == nil
		return grid.set_state(new_state)
	end

	def grid_at_coordinate(coordinate)
		return nil if coordinate.x > @maximum_coordinate.x || coordinate.y > @maximum_coordinate.y || coordinate.x < 0 || coordinate.y < 0
		grid = @grids[coordinate.x][coordinate.y]
	end
end