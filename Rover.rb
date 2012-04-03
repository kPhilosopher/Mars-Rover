#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'CardinalDirections'
require 'Coordinate'
require 'Plateau'
require 'GridStates'

class Rover
	attr_reader :start_coordinate
	attr_reader :start_direction
	attr_reader :current_direction
	attr_reader :current_coordinate
	attr_reader :plateau
	attr_reader :instruction

	def initialize(given_coordinate, given_direction)
		@start_coordinate = given_coordinate
		@start_direction = given_direction
	end

	def deploy(plateau)
		@plateau = plateau
		if plateau.state_at_coordinate(@start_coordinate) == GridStates::DefinedStates[1]
			if plateau.set_state_at_coordinate(GridStates::DefinedStates[0], @start_coordinate)
				@current_coordinate = @start_coordinate
				@current_direction = @start_direction
				return true
			end
		end
		return false
	end

	def execute_instruction(instruction)
		@instruction = instruction
		@instruction.each_char { |chr|
			if chr[/M/]
				target_coordinate = target_coordinate_with_direction
				if @plateau.state_at_coordinate(target_coordinate) == GridStates::DefinedStates[1]
					@plateau.set_state_at_coordinate(GridStates::DefinedStates[0], target_coordinate)
					previous_coordinate = @current_coordinate
					@current_coordinate = target_coordinate
					@plateau.set_state_at_coordinate(GridStates::DefinedStates[1], previous_coordinate)
				else
					puts "Rover [(#{@start_coordinate.x}, #{@start_coordinate.y}), #{@start_direction}] overrided instruction to not fall off the plateau." if @plateau.state_at_coordinate(target_coordinate) == GridStates::DefinedStates[2]
					puts "Rover [(#{@start_coordinate.x}, #{@start_coordinate.y}), #{@start_direction}] overrided instruction to not bump into an obstacle." if @plateau.state_at_coordinate(target_coordinate) == GridStates::DefinedStates[0]
				end
			elsif chr[/[LR]/]
				if chr[/L/]
					@current_direction = CardinalDirections.direction_when_rotated_left_with_direction(@current_direction)
				elsif chr[/R/]
					@current_direction = CardinalDirections.direction_when_rotated_right_with_direction(@current_direction)
				end
			end
		}
	end

	def target_coordinate_with_direction
		x_value = @current_coordinate.x
		y_value = @current_coordinate.y

		if @current_direction == 'N'
			y_value += 1 
		elsif @current_direction == 'S'
			y_value -= 1
		elsif @current_direction == 'W'
			x_value -= 1
		elsif @current_direction == 'E'
			x_value += 1
		end
		return Coordinate.new(x_value, y_value)
	end
end

