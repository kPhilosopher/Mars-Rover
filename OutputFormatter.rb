#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/02/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'Coordinate'

class OutputFormatter

	def input_text_with_lines(lines)
		input_text = ""
		lines.each do |line|
			input_text += line
		end
		return input_text
	end

	def output_text_with_report(report)
		output_text = ""
		array_count = report.size
		counter = 0
		report.each { |rover_information|
			counter += 1
			coordinate = rover_information[0]
			direction = rover_information[1]

			output_text += "#{coordinate.x} #{coordinate.y} " + direction
			output_text += "\n" if counter != array_count
		}
		return output_text
	end
end

