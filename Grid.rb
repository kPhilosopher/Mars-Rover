#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

class UndefinedStateError < Exception

end

DefinedStates = [:occupied, :unoccupied].freeze

class Grid
	attr_reader :state

	def initialize(state = :unoccupied)
		@state = state
	end

	def setState(newState)
		defined_state = false
		DefinedStates.each do |state|
			if state == newState
				defined_state = true
				break
			end
		end
		raise UndefinedStateError.new("The given state is undefined.") unless defined_state
		@state = newState
	end
end