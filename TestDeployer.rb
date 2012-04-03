#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'TestHelper'
require 'Deployer'
require 'GridPlateau'

class TestDeployer
	include Test::Unit::Assertions

	def test_parser_with_text_file_path
		deployer = Deployer.new
		text_file_name = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		parser = deployer.parser_with_text_file_path(text_file_name)

		assert_equal Parser, parser.class
	end

	def test_setup_rovers_with_instruction_set_01
		deployer = Deployer.new
		text_file_name = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		deployer.parser_with_text_file_path(text_file_name)
		deployer.setup_rovers_with_instruction_set

		deployer.rovers.each do |rover|
			assert_equal Rover, rover.class
		end

		deployer.instructions.each do |key, value|
			# puts value
			assert_not_nil value[/^[MLR]+$/]
		end

		assert_equal true, deployer.rovers.size > 0
		assert_equal deployer.rovers.size, deployer.instructions.size
	end

	def test_setup_rovers_with_instruction_set_02
		text_file_name = "input_temp.txt"
		content = "5 5\n1 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			deployer = Deployer.new
			deployer.parser_with_text_file_path(text_file_name)
			deployer.setup_rovers_with_instruction_set

			deployer.rovers.each do |rover|
				assert_equal Rover, rover.class
			end

			assert_equal deployer.instructions[deployer.rovers[0].object_id], "LMLMLMLMM"
			assert_equal deployer.instructions[deployer.rovers[1].object_id], "MMRMMRMRRM"

			assert_equal true, deployer.rovers.size == 2
			assert_equal deployer.rovers.size, deployer.instructions.size
		end
	end

	def test_setup_grid_plateau
		text_file_name = "input_temp.txt"
		content = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			deployer = Deployer.new
			deployer.parser_with_text_file_path(text_file_name)
			deployer.setup_grid_plateau
			assert_equal GridPlateau, deployer.plateau.class
			assert_equal 5, deployer.plateau.maximum_coordinate.x
			assert_equal 5, deployer.plateau.maximum_coordinate.x
		end
	end

	def test_deploy_rovers
		text_file_name = "input_temp.txt"
		content = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			deployer = Deployer.new
			deployer.parser_with_text_file_path(text_file_name)
			deployer.setup_grid_plateau
			deployer.setup_rovers_with_instruction_set

			assert_equal nil, deployer.rovers[0].current_coordinate
			
			assert_equal true, deployer.deploy_rovers
			
			assert_equal 1, deployer.rovers[0].current_coordinate.x
			assert_equal 2, deployer.rovers[0].current_coordinate.y
			assert_equal "N", deployer.rovers[0].current_direction

			assert_equal 3, deployer.rovers[1].current_coordinate.x
			assert_equal 3, deployer.rovers[1].current_coordinate.y
			assert_equal "E", deployer.rovers[1].current_direction
		end
	end

	def test_execute_instructions
		text_file_name = "input_temp.txt"
		content = "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			deployer = Deployer.new
			deployer.parser_with_text_file_path(text_file_name)
			deployer.setup_grid_plateau
			deployer.setup_rovers_with_instruction_set
			assert_equal true, deployer.deploy_rovers

			assert_equal nil, deployer.rovers[0].instruction

			deployer.execute_instructions

			assert_equal "LMLMLMLMM", deployer.rovers[0].instruction
			assert_equal "MMRMMRMRRM", deployer.rovers[1].instruction

			expected_final_coordinate = Coordinate.new(1, 3)
			expected_final_direction = "N"
			assert_equal expected_final_coordinate.x, deployer.rovers[0].current_coordinate.x
			assert_equal expected_final_coordinate.y, deployer.rovers[0].current_coordinate.y
			assert_equal expected_final_direction, deployer.rovers[0].current_direction

			expected_final_coordinate = Coordinate.new(5, 1)
			expected_final_direction = "E"
			assert_equal expected_final_coordinate.x, deployer.rovers[1].current_coordinate.x
			assert_equal expected_final_coordinate.y, deployer.rovers[1].current_coordinate.y
			assert_equal expected_final_direction, deployer.rovers[1].current_direction
		end
	end
end

# ------------------------------------------------------------------

deployer_tester = TestDeployer.new
deployer_tester.test_parser_with_text_file_path
deployer_tester.test_setup_rovers_with_instruction_set_01
deployer_tester.test_setup_rovers_with_instruction_set_02
deployer_tester.test_setup_grid_plateau
deployer_tester.test_deploy_rovers
deployer_tester.test_execute_instructions
