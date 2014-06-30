require "sequel"

class ExtraData < Sequel::Model
	def before_save
		@values[:created_at] ||= DateTime.now
		@values[:updated_at] = DateTime.now
	end
end
