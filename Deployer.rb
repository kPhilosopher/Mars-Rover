#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/31/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'Parser'
require 'Rover'
require 'Plateau'

class Deployer
	attr_reader :rovers
	attr_reader :instructions
	attr_reader :plateau

	# the initial method should allow the user to input the text file through the console.
	
	def parser_with_text_file_path(text_file_path)
		@parser = Parser.new(text_file_path)
	end

	def setup_plateau
		maximum_coordinate = @parser.extract_maximum_coordinate
		@plateau = Plateau.new(maximum_coordinate)
	end

	# TODO: have to create a method that executes parser setup before the following method
	def setup_rovers_with_instruction_set
		@rovers = []
		@instructions = Hash.new
		rovers_and_its_instruction_set = @parser.extract_rovers_and_its_instruction_set
		rovers_and_its_instruction_set.each do |rover_and_its_instruction_set|
			given_coordinate = rover_and_its_instruction_set[0]
			given_direction = rover_and_its_instruction_set[1]
			given_instruction_set = rover_and_its_instruction_set[2]
			rover = Rover.new(given_coordinate, given_direction)
			@rovers << rover
			@instructions[rover.object_id] = given_instruction_set
		end
	end


end