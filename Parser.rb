#!/usr/bin/ruby

require 'Coordinate'

class InputFormatError < Exception
end

class Parser
	attr_reader :lines
	attr_reader :maximum_coordinate
	attr_reader :rovers

	First_line = 0

	def initialize(text_file_path)
		@maximum_coordinate = Coordinate.new
		@file = File.open(text_file_path)
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

		if !first_line_parsed
			raise InputFormatError.new("Expected a maximum coordinate information line with correct format.") if broke_out == true
			raise InputFormatError.new("File is empty.")
		end
		if !one_rover_added || (broke_out && rover_line_parsed == false)
			raise InputFormatError.new("Expected a rover information line with correct format.")
		end
		if instruction_set_expected || (broke_out && rover_line_parsed == true)
			raise InputFormatError.new("Expected a instruction information line with correct format.")
		end
		@lines = temporary_lines
	end

	private

	def check_format_first_line(line)
		return true if line[(/(^\d+) (\d+$)/)] #maximum coordinate
		return false
	end

	def check_format_rover_line(line)
		return true if line[(/(^\d+) (\d+) (\w$)/)] #rover
		return false
	end

	def check_format_instruction_line(line)
		return true if (line[/[MLR]+/] != nil) && (line[/[MLR]+/].length == line[/\S+$/].length) #instructions
		return false
	end

	public

	def extract_coordinates
		temporary_x_coordinate = Integer(lines[First_line][(/(^\d+) (\d+$)/), 1])
		temporary_y_coordinate = Integer(lines[First_line][(/(^\d+) (\d+$)/), 2])

		if (temporary_y_coordinate >= 0) && (temporary_x_coordinate >= 0)
			@maximum_coordinate.x = temporary_x_coordinate
			@maximum_coordinate.y = temporary_y_coordinate
		end
		return @maximum_coordinate
	end

	def extract_rovers_and_its_instruction_set
		@rovers = []
		temporary_rover = []
		@lines.each { |line|
			if line[(/(^\d+) (\d+) (\w$)/)] #rover
				temporary_rover[0] = line[(/(^\d+) (\d+) (\w$)/), 1]
				temporary_rover[1] = line[(/(^\d+) (\d+) (\w$)/), 2]
				temporary_rover[2] = line[(/(^\d+) (\d+) (\w$)/), 3]
			elsif line[/[MLR]+/] #instructions
				temporary_rover[3] = line[/[MLR]+/]
				@rovers << temporary_rover
			end
		}
	end
end
