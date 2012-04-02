#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'TestHelper'
require 'Deployer'
require 'Plateau'

class TestDeployer
	include Test::Unit::Assertions

	def test_parser_with_text_file_path
		deployer = Deployer.new
		text_file_path = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		parser = deployer.parser_with_text_file_path(text_file_path)

		assert_equal Parser, parser.class
	end

	def test_setup_rovers_with_instruction_set_01
		deployer = Deployer.new
		text_file_path = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		deployer.parser_with_text_file_path(text_file_path)
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

	def test_setup_plateau
		text_file_name = "input_temp.txt"
		content = "5 5\n1 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_path|
			deployer = Deployer.new
			deployer.parser_with_text_file_path(text_file_path)
			deployer.setup_plateau
			assert_equal Plateau, deployer.plateau.class
			assert_equal 5, deployer.plateau.maximum_coordinate.x
			assert_equal 5, deployer.plateau.maximum_coordinate.x
		end
	end

	def test_deploy_rovers
		text_file_name = "input_temp.txt"
		content = "5 5\n1 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			deployer = Deployer.new
			deployer.parser_with_text_file_path(text_file_name)
			deployer.setup_plateau
			deployer.setup_rovers_with_instruction_set

			deployer.deploy_rovers
			deployer.rovers

		end
	end
end

# ------------------------------------------------------------------

deployer_tester = TestDeployer.new
deployer_tester.test_parser_with_text_file_path
deployer_tester.test_setup_rovers_with_instruction_set_01
deployer_tester.test_setup_rovers_with_instruction_set_02
deployer_tester.test_setup_plateau

