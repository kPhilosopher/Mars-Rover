#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'OutputFormatter'
require 'TestHelper'
require 'Coordinate'

class TestOutputFormatter
	include Test::Unit::Assertions

	def test_input_text_with_lines
		output_formatter = OutputFormatter.new
		lines = ["5 5\n", "1 2 N\n", "3 3 E"]
		input_text = output_formatter.input_text_with_lines(lines)

		assert_equal "5 5\n1 2 N\n3 3 E", input_text
	end

	def test_output_text_with_report_01
		output_formatter = OutputFormatter.new
		array = [[Coordinate.new(1, 3), "N"], [Coordinate.new(5, 1), "E"]]
		output_text = output_formatter.output_text_with_report(array)
		
		assert_equal "1 3 N\n5 1 E", output_text
	end

	def test_output_text_with_report_02
		output_formatter = OutputFormatter.new
		array = [[Coordinate.new(1, 3), "N"]]
		output_text = output_formatter.output_text_with_report(array)
		
		assert_equal "1 3 N", output_text
	end
end

# ------------------------------------------------------------------

output_formatter_tester = TestOutputFormatter.new
output_formatter_tester.test_input_text_with_lines
output_formatter_tester.test_output_text_with_report_01
output_formatter_tester.test_output_text_with_report_02

