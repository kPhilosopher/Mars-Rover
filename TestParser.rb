#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/30/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'Parser'
require 'Coordinate'
require 'TestHelper'

class TestParser 
	include Test::Unit::Assertions

	def test_text_file_is_opened_and_read
		file_path = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		assert_nothing_raised do
		 Parser.new(file_path)
		end
	end

	def test_non_existant_file_cant_be_opened
		file_path = File.expand_path(File.dirname(__FILE__) + '/no_such_file.txt')
		assert_raise(Errno::ENOENT) do
		 Parser.new(file_path)
		end
	end

	def test_check_format
		file_path = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		file = Parser.new(file_path)
		assert_nothing_raised(InputFormatError) do
		 file.check_format
		end
	end

	def test_check_format_with_incorrect_cardinal_direction
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 2 A\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a rover information line with correct format.", ex.message
		end
	end

	def test_check_format_with_irrelevant_extra_lines
		text_file_name = "input_with_error.txt"
		content = "5 5\nblabla\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a rover information line with correct format.", ex.message
		end
	end

	def test_check_format_with_first_line_error
		text_file_name = "input_with_error.txt"
		content = "5 5 N\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a maximum coordinate information line with correct format.", ex.message
		end
	end

	def test_check_format_with_rover_line_error
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 2 NN\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a rover information line with correct format.", ex.message
		end
	end

	def test_check_format_with_instruction_line_error_01
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 2 N\nLM3LMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a instruction information line with correct format.", ex.message
		end
	end

	def test_check_format_with_instruction_line_error_02
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 2 N\nLMLMLMLMM M\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a instruction information line with correct format.", ex.message
		end
	end

	def test_check_format_with_instruction_line_error_03
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 2 N\nLMLMLMLMMDM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
			assert_equal "Expected a instruction information line with correct format.", ex.message
		end
	end

	def test_check_format_with_first_line_missing
		text_file_name = "input_with_error.txt"
		content = "1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a maximum coordinate information line with correct format.", ex.message
		end
	end

	def test_check_format_with_rover_line_missing
		text_file_name = "input_with_error.txt"
		content = "5 5\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a rover information line with correct format.", ex.message
		end
	end

	def test_check_format_with_instruction_line_missing_01
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 2 N\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a instruction information line with correct format.", ex.message
		end
	end

	def test_check_format_with_instruction_line_missing_02
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 2 N\nMMRMMRMRRM\n3 3 E\n"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a instruction information line with correct format.", ex.message
		end
	end
	def test_check_format_with_rover_line_and_instruction_line_mixed_up
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 2 N\nMRMM\nMMRMMRMRRM\n3 3 E"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a rover information line with correct format.", ex.message
		end
	end

	def test_check_format_with_text_file_that_is_empty
		text_file_name = "input_with_error.txt"
		content = ""

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "File is empty.", ex.message
		end
	end

	def test_check_format_with_text_file_that_has_empty_line
		text_file_name = "input_with_error.txt"
		content = "\n"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a maximum coordinate information line with correct format.", ex.message
		end
	end

	def test_check_format_with_no_rover_and_no_instruction_set
		text_file_name = "input_with_error.txt"
		content = "5 5"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a rover information line with correct format.", ex.message
		end
	end

	def test_check_format_with_one_rover_and_no_instruction_set
		text_file_name = "input_with_error.txt"
		content = "5 5\n3 4 N"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a instruction information line with correct format.", ex.message
		end
	end

	def test_check_format_with_negative_maximum_coordinate
		text_file_name = "input_with_error.txt"
		content = "5 -5\n3 4 N\nMLLRMM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			begin
				file.check_format
		    rescue InputFormatError => ex
		    end

		    assert_equal InputFormatError, ex.class
		    assert_equal "Expected a maximum coordinate information line with correct format.", ex.message
		end
	end

	def test_extract_maximum_coordinate
		file_path = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		file = Parser.new(file_path)
		maximum_coordinate = file.extract_maximum_coordinate
		assert_equal true, maximum_coordinate.x >= 0
		assert_equal true, maximum_coordinate.y >= 0
	end

	def test_extract_rovers_and_its_instruction_set_01
		file = Parser.new(filePath = File.expand_path(File.dirname(__FILE__) + '/input.txt'))
		rovers = file.extract_rovers_and_its_instruction_set
		rovers.each { |rover|
			assert_equal Coordinate, rover[0].class
			assert_not_nil rover[1][/^[NSEW]$/]
			assert_not_nil rover[2][/^[MLR]+$/]
		}
	end

	def test_extract_rovers_and_its_instruction_set_02
		text_file_name = "input_temp.txt"
		content = "5 5\n1 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			rovers = file.extract_rovers_and_its_instruction_set
			assert_equal rovers[0][2], "LMLMLMLMM"
			assert_equal rovers[1][2], "MMRMMRMRRM"
		end
	end

	def test_extract_maximum_coordinate_with_both_zero
		# TODO
	end

	def test_extract_rovers_and_its_instruction_set_with_incorrect_rover_starting_coordinates
		text_file_name = "input_with_error.txt"
		content = "5 5\n1 8 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

		create_and_delete_text_file(text_file_name, content) do |text_file_name|
			file_path = File.expand_path(File.dirname(__FILE__) + "/" + text_file_name)
			file = Parser.new(file_path)
			
		    begin
		    	file.extract_rovers_and_its_instruction_set
		    rescue InputLogicError => ex
		    end

		    assert_equal InputLogicError, ex.class
		    assert_equal "Rover coordinate cannot be larger than the maximum coordinate.", ex.message
		end
	end


end

# ------------------------------------------------------------------

parsing_tester = TestParser.new
parsing_tester.test_text_file_is_opened_and_read
parsing_tester.test_non_existant_file_cant_be_opened
parsing_tester.test_check_format
parsing_tester.test_check_format_with_incorrect_cardinal_direction
parsing_tester.test_check_format_with_irrelevant_extra_lines
parsing_tester.test_check_format_with_first_line_error
parsing_tester.test_check_format_with_rover_line_error
parsing_tester.test_check_format_with_instruction_line_error_01
parsing_tester.test_check_format_with_instruction_line_error_02
parsing_tester.test_check_format_with_instruction_line_error_03
parsing_tester.test_check_format_with_first_line_missing
parsing_tester.test_check_format_with_rover_line_missing
parsing_tester.test_check_format_with_instruction_line_missing_01
parsing_tester.test_check_format_with_instruction_line_missing_02
parsing_tester.test_check_format_with_rover_line_and_instruction_line_mixed_up
parsing_tester.test_check_format_with_text_file_that_is_empty
parsing_tester.test_check_format_with_text_file_that_has_empty_line
parsing_tester.test_check_format_with_no_rover_and_no_instruction_set
parsing_tester.test_check_format_with_one_rover_and_no_instruction_set
parsing_tester.test_check_format_with_negative_maximum_coordinate
parsing_tester.test_extract_maximum_coordinate
parsing_tester.test_extract_rovers_and_its_instruction_set_01
parsing_tester.test_extract_rovers_and_its_instruction_set_02
parsing_tester.test_extract_rovers_and_its_instruction_set_with_incorrect_rover_starting_coordinates
