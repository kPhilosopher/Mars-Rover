#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

class CardinalDirections

	CardinalDirections = ["N", "E", "S", "W"].freeze

	def self.direction_when_rotated_left_with_direction(direction)
		marked_index = self.marked_index_in_cardinal_array_with_direction(direction)
		return CardinalDirections[marked_index - 1]
	end

	def self.direction_when_rotated_right_with_direction(direction)
		marked_index = self.marked_index_in_cardinal_array_with_direction(direction)
		return CardinalDirections[marked_index - 3]
	end

	private

	def self.marked_index_in_cardinal_array_with_direction(direction)
		index = 0
		marked_index = 99
		CardinalDirections.each do |cardinal_direction|
			if direction == cardinal_direction
				marked_index = index
			end
			index += 1
		end
		return marked_index
	end
end

