#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/31/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'Parser'
require 'Rover'
require 'GridPlateau'
require 'OutputFormatter'

class Deployer

	attr_reader :rovers
	attr_reader :instructions
	attr_reader :plateau

	def initialize(input_text)
		if input_text != nil
			parser_with_text_file_path(input_text)
			setup_grid_plateau
			setup_rovers_with_instruction_set
			deploy_rovers
			execute_instructions
			output_final_status
		end
	end

	def parser_with_text_file_path(text_file_name)
		@parser = Parser.new(text_file_name)
		begin
			@parser.check_format
			@parser.extract_maximum_coordinate
			@parser.extract_rovers_and_its_instruction_set
		rescue Exception => e
			puts e.message
			puts "Please fix the error in the input.txt before restarting the program."
			exit
		end

		output_formatter = OutputFormatter.new
		input_text = output_formatter.input_text_with_lines(@parser.lines)
		puts "=========="
		puts "Input text:"
		puts "=========="
		puts input_text
		puts "=========="
		return @parser
	end

	def setup_grid_plateau
		maximum_coordinate = @parser.maximum_coordinate
		@plateau = GridPlateau.new(maximum_coordinate)
	end

	def setup_rovers_with_instruction_set
		@rovers = []
		@instructions = Hash.new
		rovers_and_its_instruction_set = @parser.rovers_and_its_instruction_set
		rovers_and_its_instruction_set.each do |rover_and_its_instruction_set|
			given_coordinate = rover_and_its_instruction_set[0]
			given_direction = rover_and_its_instruction_set[1]
			given_instruction_set = rover_and_its_instruction_set[2]
			rover = Rover.new(given_coordinate, given_direction)
			@rovers << rover
			@instructions[rover.object_id] = given_instruction_set
		end
	end

	def deploy_rovers
		@rovers.each do |rover|
			return false if !rover.deploy(@plateau)
		end
		return true
	end

	def execute_instructions
		@rovers.each do |rover|
			rover.execute_instruction(@instructions[rover.object_id])
		end
	end

	def output_final_status
		report = rovers_report
		output_formatter = OutputFormatter.new
		output_text = output_formatter.output_text_with_report(report)
		puts "=========="
		puts "the rovers' status after executing instruction sets"
		puts "=========="
		puts output_text
		puts "=========="
		File.open("output.txt", 'w') do |file|  
		file.print output_text
		end
	end

	def rovers_report
		final_status = []
		@rovers.each do |rover|
			final_status << [rover.current_coordinate, rover.current_direction]
		end
		return final_status
	end
end

# ------------------------------------------------------------------

input_text = "input.txt"
deployer = Deployer.new(input_text)

