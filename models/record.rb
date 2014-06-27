require "sequel"

class Record < Sequel::Model
	def before_save
		@values[:created_at] ||= DateTime.now
		@values[:updated_at] = DateTime.now
	end

	many_to_one :team
	many_to_one :match
end
