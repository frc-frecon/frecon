# lib/frecon/configuration.rb
#
# Copyright (C) 2015 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/configuration_file"

module FReCon
	class Configuration < Hash
		def initialize(data)
			data.each do |key, value|
				self[key] = value
			end
		end

		def merge(other)
			case other
			when Configuration, Hash
				other.each do |key, value|
					case value
					when Configuration, Hash
						me = Configuration.new(self[key] || {})
						me.merge(Configuration.new(value))
						self[key] = me
					else
						self[key] = value
					end
				end
			when nil
			end
		end

		def self.construct!(default_configuration: ConfigurationFile.default.read,
		                    system_configuration: ConfigurationFile.system.read,
		                    user_configuration: ConfigurationFile.user.read,
		                    argument_configuration: nil)

			configuration_hierarchy = [default_configuration, system_configuration, user_configuration, argument_configuration]

			configuration = Configuration.new({})
			configuration_hierarchy.each do |other_configuration|
				configuration.merge(other_configuration)
			end

			configuration
		end
	end
end
