#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/30/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'Parser'
require 'Coordinate'

class TestParser 
	include Test::Unit::Assertions

	def test_text_file_is_opened_and_read
		file_path = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		assert_nothing_raised do
		 Parser.new(file_path)
		end
	end

	def test_no_such_file_cant_be_opened
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

	def create_and_delete_text_file(text_file_name, content)
		File.open(text_file_name, 'w') do |file|  
			file.print content
  		end

  		yield(text_file_name)

  		File.delete(text_file_name)
	end

	def test_check_format_with_irrelevant_extra_lines
		text_file_name = "input_with_first_line_error.txt"
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
		text_file_name = "input_with_first_line_error.txt"
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
		text_file_name = "input_with_rover_line_error.txt"
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
		text_file_name = "input_with_instruction_line_error.txt"
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
		text_file_name = "input_with_instruction_line_error.txt"
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
		text_file_name = "input_with_instruction_line_error.txt"
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
				text_file_name = "input_with_first_line_missing.txt"
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
		text_file_name = "input_with_rover_line_missing.txt"
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
		text_file_name = "input_with_instruction_line_missing.txt"
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
		text_file_name = "input_with_instruction_line_missing.txt"
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
		text_file_name = "input_with_rover_line_and_instruction_line_mixed_up.txt"
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

	def test_text_file_that_is_empty
		text_file_name = "input_with_nothing.txt"
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

	def test_text_file_that_has_one_line
		text_file_name = "input_with_one_line.txt"
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

	def test_text_file_has_no_rover_and_no_instruction_set
		text_file_name = "input_with_just_maximum_coordinate.txt"
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

	def test_text_file_has_one_rover_and_no_instruction_set
		text_file_name = "input_with_maximum_coordinate_and_just_a_rover.txt"
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

	def test_text_file_has_negative_maximum_coordinate
		text_file_name = "input_with_negative_coordinate.txt"
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

	def test_text_file_has_maximum_size_coordinates
		file_path = File.expand_path(File.dirname(__FILE__) + '/input.txt')
		file = Parser.new(file_path)
		file.check_format
		maximum_coordinate = file.extract_coordinates
		assert_equal true, maximum_coordinate.x >= 0
		assert_equal true, maximum_coordinate.y >= 0
	end

	def test_text_file_has_first_rover_and_its_instruction_set
		file = Parser.new(filePath = File.expand_path(File.dirname(__FILE__) + '/input.txt'))
		file.check_format
		file.extract_rovers_and_its_instruction_set
		file.rovers.each { |rover|
			assert_not_nil rover[0][/\d+/]
			assert_not_nil rover[1][/\d+/]
			assert_not_nil rover[2][/\w/]
			assert_not_nil rover[3][/[MLR]+/]
		}
	end
end

# ------------------------------------------------------------------

parsing_tester = TestParser.new
parsing_tester.test_text_file_is_opened_and_read
parsing_tester.test_no_such_file_cant_be_opened
parsing_tester.test_check_format
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
parsing_tester.test_text_file_that_is_empty
parsing_tester.test_text_file_that_has_one_line
parsing_tester.test_text_file_has_no_rover_and_no_instruction_set
parsing_tester.test_text_file_has_one_rover_and_no_instruction_set
parsing_tester.test_text_file_has_maximum_size_coordinates
parsing_tester.test_text_file_has_negative_maximum_coordinate
parsing_tester.test_text_file_has_first_rover_and_its_instruction_set
