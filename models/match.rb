require_relative "extra_data"
require "sequel"

class Match < Sequel::Model
	def before_save
		@values[:created_at] ||= DateTime.now
		@values[:updated_at] = DateTime.now
	end

	def extra_data
		return ExtraData.where(parent_key: self.id, parent_class: self.class.name)
	end

	many_to_one :competition
	one_to_many :records, primary_key: :id
end
