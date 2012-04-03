#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'
require 'OutputFormatter'
require 'TestHelper'
require 'Coordinate'

class TestOutputFormatter
	include Test::Unit::Assertions

	def test_output_text_with_array_01
		output_formatter = OutputFormatter.new
		array = [[Coordinate.new(1, 3), "N"], [Coordinate.new(5, 1), "E"]]
		output_text = output_formatter.output_text_with_report(array)
		
		assert_equal "1 3 N\n5 1 E", output_text
	end

	def test_output_text_with_array_02
		output_formatter = OutputFormatter.new
		array = [[Coordinate.new(1, 3), "N"]]
		output_text = output_formatter.output_text_with_report(array)
		
		assert_equal "1 3 N", output_text
	end
end

# ------------------------------------------------------------------

output_formatter_tester = TestOutputFormatter.new
output_formatter_tester.test_output_text_with_array_01
output_formatter_tester.test_output_text_with_array_02

