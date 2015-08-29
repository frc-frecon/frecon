# lib/frecon/model.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "mongoid"
require "frecon/mongoid/criteria"

module FReCon
	# Public: A base class designed to assist with creating MongoDB Models
	# elsewhere in the project.
	class Model
		def self.inherited(child)
			child.class_eval do
				include Mongoid::Document
				include Mongoid::Timestamps
				include Mongoid::Attributes::Dynamic

				validate :no_invalid_relations

				self.class_variable_set(:@@attributes, [])

				def self.register_routable_relation(method, attribute)
					self.class_variable_get(:@@attributes) << {method: method, type: :relation, attribute: attribute}
				end

				def self.register_routable_attribute(method, attribute)
					self.class_variable_get(:@@attributes) << {method: method, type: :attribute, attribute: attribute}
				end
			end
		end

		def self.descendants
			# Basically lists all of the models in this database.
			ObjectSpace.each_object(Class).select { |possibleChild| possibleChild < self }
		end

		def self.controller
			(self.name.pluralize + "Controller").constantize
		end

		def no_invalid_relations
			# Get all of the belongs_to fields (ends with "_id" and not "_id" because that is the id).
			attributes.keys.select { |attribute| attribute.end_with?("_id") && attribute != "_id" }.each do |relation|
				# Get the model for the belongs_to association.
				model = "FReCon::".concat(relation.gsub(/_id\Z/, "").capitalize).constantize
				errors.add(relation.to_sym, "is invalid") if relation_invalid(model, send(relation))
			end
		end

		def relation_invalid(class_constant, id)
			class_constant.find_by(id: id).nil?
		end
	end
end
