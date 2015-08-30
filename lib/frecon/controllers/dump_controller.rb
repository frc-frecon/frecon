# lib/frecon/controllers/dump_controller.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "json"
require "frecon/models"

module FReCon
	# Public: The Dump controller.
	class DumpController
		# Public: Creates a dump.
		#
		# Returns a String containing a dump of the database.
		def self.full(params)
			dump = {}

			ordered_descendants = Model.descendants.sort_by do |model|
				id_fields = model.fields.keys.select do |attribute|
					attribute.ends_with?("_id") && attribute != "_id"
				end

				[id_fields.count, dump_compliant_name(model)]
			end

			ordered_descendants.each do |child|
				dump[dump_compliant_name(child)] = child.all
			end

			dump.to_json
		end

		def self.dump_compliant_name(model)
			model.name.gsub(/FReCon::/, "").downcase.pluralize
		end
	end
end
