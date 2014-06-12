require "sequel"

class Team < Sequel::Model
	def methods()
		self.class_methods +
			self.instance_methods
	end

	Int :number
	String :name

	DateTime :created_at
	DateTime :updated_at

	self.set_primary_key(:number)
end
