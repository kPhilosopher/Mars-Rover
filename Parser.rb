#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/30/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'Coordinate'

class InputFormatError < Exception
end

class InputLogicError <Exception
end

class Parser
	attr_reader :lines
	attr_reader :maximum_coordinate
	attr_reader :rovers_and_its_instruction_set

	First_line = 0

	def initialize(text_file_name)
		@file = File.open(text_file_name)
	end

	def check_format
		first_line_parsed = false
		rover_line_parsed = false
		broke_out = false
		one_rover_added = false
		instruction_set_expected = false
		temporary_lines = []

		@file.each_line { |line|
			temporary_lines << line 
			if !first_line_parsed
				first_line_parsed = check_format_first_line(line)
				broke_out = true if !first_line_parsed
			elsif !rover_line_parsed
				rover_line_parsed = check_format_rover_line(line)
				broke_out = true if !rover_line_parsed

				one_rover_added = true
				instruction_set_expected = true
			elsif rover_line_parsed
				rover_line_parsed = !check_format_instruction_line(line)
				broke_out = true if rover_line_parsed

				instruction_set_expected = false
			end
			break if broke_out == true
		}

		@lines = temporary_lines

		if !first_line_parsed
			raise InputFormatError.new("Expected a maximum coordinate information line with correct format.") if broke_out == true
			raise InputFormatError.new("File is empty.")
		end
		if !one_rover_added || (broke_out && rover_line_parsed == false)
			raise InputFormatError.new("Expected a rover information line with correct format.")
		end
		if instruction_set_expected || (broke_out && rover_line_parsed == true)
			raise InputFormatError.new("Expected an instruction information line with correct format.")
		end
	end

	private

	def check_format_first_line(line)
		return true if line[(/(^\d+) (\d+$)/)] #maximum coordinate
		return false
	end

	def check_format_rover_line(line)
		return true if line[(/(^\d+) (\d+) ([NSEW]$)/)] #rover
		return false
	end

	def check_format_instruction_line(line)
		return true if (line[/[MLR]+/] != nil) && (line[/[MLR]+/].length == line[/\S+$/].length) #instructions
		return false
	end

	public

	def extract_maximum_coordinate
		check_format if @lines == nil
		temporary_x_coordinate = Integer(@lines[First_line][(/(^\d+) (\d+$)/), 1])
		temporary_y_coordinate = Integer(@lines[First_line][(/(^\d+) (\d+$)/), 2])
		@maximum_coordinate = Coordinate.new(temporary_x_coordinate, temporary_y_coordinate)
	end

	def extract_rovers_and_its_instruction_set
		check_format if @lines == nil
		extract_maximum_coordinate if @maximum_coordinate == nil
		@rovers_and_its_instruction_set = []
		temporary_rover = []
		@lines.each { |line|
			if line[/(^\d+) (\d+) ([NSEW]$)/] #rover
				temporary_x_coordinate = Integer(line[(/(^\d+) (\d+) ([NSEW]$)/), 1])
				temporary_y_coordinate = Integer(line[(/(^\d+) (\d+) ([NSEW]$)/), 2])
				
				temporary_rover[0] = Coordinate.new(temporary_x_coordinate, temporary_y_coordinate)
				
				raise InputLogicError.new("Rover coordinate cannot be larger than the maximum coordinate.") if temporary_x_coordinate > @maximum_coordinate.x
				raise InputLogicError.new("Rover coordinate cannot be larger than the maximum coordinate.") if temporary_y_coordinate > @maximum_coordinate.y
				@rovers_and_its_instruction_set.each do |previous_rover|
					if (previous_rover[0].x == temporary_rover[0].x) && (previous_rover[0].y == temporary_rover[0].y)
						raise InputLogicError.new("Multiple rovers have a same starting coordinate.")
					end
				end

				temporary_rover[1] = line[(/(^\d+) (\d+) ([NSEW]$)/), 3]
			elsif line[/[MLR]+/] #instructions
				temporary_rover[2] = line[/[MLR]+/]
				@rovers_and_its_instruction_set << temporary_rover
				temporary_rover = []
			end
		}
	end
end


