module FReCon
	class Model
		include Mongoid::Document
		include Mongoid::Timestamps
		include Mongoid::Attributes::Dynamic
	end
end
