#!/usr/bin/ruby

# Created by Jinwoo Baek on 3/30/12.
# Copyright (c) 2012 Jinwoo Baek. All rights reserved.

require 'test/unit/assertions'


def create_and_delete_text_file(text_file_name, content)
	File.open(text_file_name, 'w') do |file|  
		file.print content
	end

	yield(text_file_name)

	File.delete(text_file_name)
end