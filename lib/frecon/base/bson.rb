# lib/frecon/base/bson.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

# Public: An extension for the BSON module.
module BSON
	# Public: A monkey-patch for BSON::ObjectId which introduces a #as_json
	# method.
	class ObjectId
		# Public: Get produce a JSON representation of this ObjectId.
		#
		# Since we don't want to produce a JSON Object for every ID, this method
		# instead just returns the String _id value within this object.
		#
		# Returns a String containing the value of this ObjectId.
		def as_json(*args)
			to_s
		end
	end
end
