require "mongoid"

module FReCon
	class Model
		def self.inherited(child)
			child.class_eval do
				include Mongoid::Document
				include Mongoid::Timestamps
				include Mongoid::Attributes::Dynamic

				validate :no_invalid_relations
			end
		end

		def no_invalid_relations
			attributes.keys.select { |attribute| attribute.end_with?("_id") && attribute != "_id" }.each do |relation|
				model = "FReCon::".concat(relation.gsub(/_id\Z/, "").capitalize).constantize
				errors.add(relation.to_sym, "is invalid") if relation_invalid(model, send(relation))
			end
		end

		def relation_invalid(class_constant, id)
			class_constant.find_by(id: id).nil?
		end
	end
end
