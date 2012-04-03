#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'GridStates'
require 'Rover'
require 'GridPlateau'

class TestRover
	include Test::Unit::Assertions

	def test_initialized_rover
		rover = Rover.new(nil, nil)
		assert_equal Rover, rover.class
	end

	def test_start_coordinate
		rover = Rover.new(nil, nil)
		assert_equal nil, rover.start_coordinate
		assert_equal nil, rover.start_direction

		# ----------------------------------------------------------

		rover = Rover.new(Coordinate.new(10, 2), nil)
		assert_equal Coordinate.new(10, 2).x, rover.start_coordinate.x
		assert_equal Coordinate.new(10, 2).y, rover.start_coordinate.y
		assert_equal nil, rover.start_direction
	end

	def test_start_direction
		rover = Rover.new(nil, "S")
		assert_equal "S", rover.start_direction
	end

	def test_deploy
		coordinate = Coordinate.new(3, 2)
		direction = "N"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 6)
		plateau = GridPlateau.new(maximum_coordinate)

		assert_equal nil, rover.current_coordinate
		assert_equal nil, rover.current_direction
		assert_equal maximum_coordinate.x, plateau.maximum_coordinate.x
		assert_equal maximum_coordinate.y, plateau.maximum_coordinate.y
		assert_equal :unoccupied, plateau.state_at_coordinate(coordinate)

		assert_equal true, rover.deploy(plateau)

		assert_equal coordinate.x, rover.current_coordinate.x
		assert_equal coordinate.y, rover.current_coordinate.y
		assert_equal direction, rover.current_direction
		assert_equal :occupied, rover.plateau.state_at_coordinate(coordinate)
	end

	def test_execute_instruction_M
		coordinate = Coordinate.new(1, 2)
		direction = "N"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		instruction = "M"
		rover.execute_instruction(instruction)
		assert_equal instruction, rover.instruction
		
		expected_final_coordinate = Coordinate.new(1, 3)
		expected_final_direction = "N"
		assert_equal expected_final_coordinate.x, rover.current_coordinate.x
		assert_equal expected_final_coordinate.y, rover.current_coordinate.y
		assert_equal expected_final_direction, rover.current_direction
		assert_equal GridStates::DefinedStates[1], rover.plateau.state_at_coordinate(coordinate)
		assert_equal GridStates::DefinedStates[0], rover.plateau.state_at_coordinate(expected_final_coordinate)
	end

	def test_execute_instruction_L
		coordinate = Coordinate.new(1, 2)
		direction = "N"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		instruction = "L"
		rover.execute_instruction(instruction)
		assert_equal instruction, rover.instruction
		
		expected_final_coordinate = Coordinate.new(1, 2)
		expected_final_direction = "W"
		assert_equal expected_final_coordinate.x, rover.current_coordinate.x
		assert_equal expected_final_coordinate.y, rover.current_coordinate.y
		assert_equal expected_final_direction, rover.current_direction
	end

	def test_execute_instruction_R
		coordinate = Coordinate.new(1, 2)
		direction = "N"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		instruction = "R"
		rover.execute_instruction(instruction)
		assert_equal instruction, rover.instruction
		
		expected_final_coordinate = Coordinate.new(1, 2)
		expected_final_direction = "E"
		assert_equal expected_final_coordinate.x, rover.current_coordinate.x
		assert_equal expected_final_coordinate.y, rover.current_coordinate.y
		assert_equal expected_final_direction, rover.current_direction
	end

	def test_execute_instruction_M_off_the_plateau
		coordinate = Coordinate.new(1, 2)
		direction = "N"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(2, 2)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		instruction = "M"
		rover.execute_instruction(instruction)
		assert_equal instruction, rover.instruction
		
		expected_final_coordinate = Coordinate.new(1, 2)
		expected_final_direction = "N"
		assert_equal expected_final_coordinate.x, rover.current_coordinate.x
		assert_equal expected_final_coordinate.y, rover.current_coordinate.y
		assert_equal expected_final_direction, rover.current_direction
	end

	def test_execute_instruction_M_into_another_rover
		coordinate = Coordinate.new(1, 2)
		direction = "N"
		rover1 = Rover.new(coordinate, direction)
		coordinate = Coordinate.new(1, 1)
		direction = "N"
		rover2 = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(2, 2)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover1.deploy(plateau)
		assert_equal true, rover2.deploy(plateau)

		instruction = "M"
		rover2.execute_instruction(instruction)
		assert_equal instruction, rover2.instruction
		
		expected_final_coordinate = Coordinate.new(1, 1)
		expected_final_direction = "N"
		assert_equal expected_final_coordinate.x, rover2.current_coordinate.x
		assert_equal expected_final_coordinate.y, rover2.current_coordinate.y
		assert_equal expected_final_direction, rover2.current_direction
	end

	def test_execute_instruction_set
		text_file_name = "input_temp.txt"
		content = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		coordinate = Coordinate.new(1, 2)
		direction = "N"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		instruction = "LMLMLMLMM"
		rover.execute_instruction(instruction)
		assert_equal instruction, rover.instruction
		
		expected_final_coordinate = Coordinate.new(1, 3)
		expected_final_direction = "N"
		assert_equal expected_final_coordinate.x, rover.current_coordinate.x
		assert_equal expected_final_coordinate.y, rover.current_coordinate.y
		assert_equal expected_final_direction, rover.current_direction
	end

	def test_target_coordinate_with_direction
		coordinate = Coordinate.new(1, 2)
		direction = "N"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		excpected_coordinate = Coordinate.new(1, 3)
		assert_equal excpected_coordinate.x, rover.target_coordinate_with_direction.x
		assert_equal excpected_coordinate.y, rover.target_coordinate_with_direction.y

		# ------------------------------------------------------------------

		coordinate = Coordinate.new(1, 2)
		direction = "E"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		excpected_coordinate = Coordinate.new(2, 2)
		assert_equal excpected_coordinate.x, rover.target_coordinate_with_direction.x
		assert_equal excpected_coordinate.y, rover.target_coordinate_with_direction.y

		# ------------------------------------------------------------------

		coordinate = Coordinate.new(1, 2)
		direction = "S"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		excpected_coordinate = Coordinate.new(1, 1)
		assert_equal excpected_coordinate.x, rover.target_coordinate_with_direction.x
		assert_equal excpected_coordinate.y, rover.target_coordinate_with_direction.y

		# ------------------------------------------------------------------

		coordinate = Coordinate.new(1, 2)
		direction = "W"
		rover = Rover.new(coordinate, direction)
		maximum_coordinate = Coordinate.new(5, 5)
		plateau = GridPlateau.new(maximum_coordinate)
		assert_equal true, rover.deploy(plateau)

		excpected_coordinate = Coordinate.new(0, 2)
		assert_equal excpected_coordinate.x, rover.target_coordinate_with_direction.x
		assert_equal excpected_coordinate.y, rover.target_coordinate_with_direction.y
	end

end

# ------------------------------------------------------------------

rover_tester = TestRover.new
rover_tester.test_initialized_rover
rover_tester.test_start_coordinate
rover_tester.test_start_direction
rover_tester.test_deploy
rover_tester.test_execute_instruction_M
rover_tester.test_execute_instruction_L
rover_tester.test_execute_instruction_R
rover_tester.test_execute_instruction_set
rover_tester.test_target_coordinate_with_direction
rover_tester.test_execute_instruction_M_off_the_plateau
rover_tester.test_execute_instruction_M_into_another_rover
