require "sequel"

class ExtraData < Sequel::Model(:extra_data)
	def before_save
		@values[:created_at] ||= DateTime.now
		@values[:updated_at] = DateTime.now
	end
end
