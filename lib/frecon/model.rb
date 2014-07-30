require "mongoid"

module FReCon
	class Model
		include Mongoid::Document
		include Mongoid::Timestamps
	end
end
