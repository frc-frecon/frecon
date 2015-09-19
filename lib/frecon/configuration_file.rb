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
	# Public: A class to handle configuration files.
	class ConfigurationFile
		# Public: The filename for the file.
		attr_accessor :filename

		# Public: Initialize a ConfigurationFile.
		#
		# filename - The name of the file.
		def initialize(filename)
			@filename = filename
		end

		# Public: Read from the file and generate a Configuration
		# from the YAML data therein.
		#
		# Returns a Configuration representing the file's data or nil if it didn't
		# exist.
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

		# Public: Create a new ConfigurationFile corresponding to the default
		# defaults configuration location.
		def self.default
			self.new(File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "config", "default.yml")))
		end

		# Public: Create a new ConfigurationFile corresponding to the default
		# system configuration location.
		def self.system
			self.new(File.join("", "etc", "frecon", "config.yml"))
		end

		# Public: Create a new ConfigurationFile corresponding to the default
		# user configuration location.
		def self.user
			self.new(File.join(Dir.home, ".config", "frecon.yml"))
		end

		protected

		# Public: Returns the User's config home directory.
		def self.config_directory
			ENV['XDG_CONFIG_HOME'] || File.join(Dir.home, '.config')
		end
	end
end
