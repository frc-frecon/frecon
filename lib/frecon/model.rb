module FReCon
	class Model
		include Mongoid::Document
		include Mongoid::Timestamps
		include Mongoid::Attributes::Dynamic

		def id
			self._id.to_s
		end
	end
end
