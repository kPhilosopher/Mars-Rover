#!/usr/bin/ruby

# Created by Jinwoo Baek on 4/01/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'GridStates'

class Grid
	attr_reader :state

	def initialize(state = :unoccupied)
		@state = state
	end

	def set_state(new_state)
		defined_state = false
		GridStates::DefinedStates.each do |state|
			if state == new_state
				defined_state = true
				break
			end
		end
		return false unless defined_state
		@state = new_state
		return true
	end
end

