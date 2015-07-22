# lib/frecon/mongoid/criteria.rb
#
# Copyright (C) 2015 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "mongoid"

module Mongoid
	class Criteria
		def psv_filter(psv_parameters = {})
			collection = self

			psv_parameters.each do |psv_string, comparison_value|
				psv_keys = psv_string.split(" ").map do |psv_key|
					psv_key.to_sym
				end.reverse

				comparison_key = psv_keys.shift

				if comparison_value.length == 0 || comparison_value == "__nil__"
					comparison_hash = {comparison_key => nil}
				else
					comparison_hash = {comparison_key => comparison_value}
				end

				p comparison_hash

				psv_keys.each do |model|
					model_id = (model.to_s + '_id').to_sym
					model_class = ("FReCon::" + model.to_s.capitalize).constantize

					comparison_hash = {model_id => model_class.in(comparison_hash).map(&:id)}

					p comparison_hash
				end

				collection = collection.in(comparison_hash)
			end

			collection
		end
	end
end
