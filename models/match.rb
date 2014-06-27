require "sequel"

class Match < Sequel::Model
	def before_save
		@values[:created_at] ||= DateTime.now
		@values[:updated_at] = DateTime.now
	end

	one_to_many :records, :primary_key => :number
end
