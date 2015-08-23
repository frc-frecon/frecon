# lib/frecon/configuration_file.rb
#
# Copyright (C) 2015 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "yaml"
require "frecon/configuration"

module FReCon
	class ConfigurationFile
		attr_accessor :filename

		def initialize(filename)
			@filename = filename
		end

		def read
			begin
				data = open(@filename, "rb") do |io|
					io.read
				end

				Configuration.new(YAML.load(data))
			rescue Errno::ENOENT
				nil
			end
		end

		def self.default
			self.new(File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "config", "default.yml")))
		end

		def self.system
			self.new(File.join("", "etc", "frecon", "config.yml"))
		end

		def self.user
			self.new(File.join(Dir.home, "config", "frecon.yml"))
		end
	end
end