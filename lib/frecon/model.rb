require "mongoid"

module FReCon
	class Model
		include Mongoid::Document
		include Mongoid::Timestamps
	end

	class DynamicAttributesModel < Model
		include Mongoid::Attributes::Dynamic
	end
end
