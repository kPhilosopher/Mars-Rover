#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'Plateau'
require 'Grid'

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

	def state_at(coordinate)
		if coordinate.x > @maximum_coordinate.x || coordinate.y > @maximum_coordinate.y
			
		end
		grid = @grids[coordinate.x][coordinate.y]
		return grid.state
	end
end