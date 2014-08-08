require "mongoid"

module FReCon
	class Model
		def self.inherited(child)
			child.class_eval do
				include Mongoid::Document
				include Mongoid::Timestamps
				include Mongoid::Attributes::Dynamic		
			end
		end
	end
end
