require_relative "extra_data"
require "sequel"

class Team < Sequel::Model
	def before_save
		@values[:created_at] ||= DateTime.now
		@values[:updated_at] = DateTime.now
	end

	def extra_data
		return ExtraData.where(parent_key: self.number, parent_class: self.class.name)
	end

	one_to_many :participations, primary_key: :id
	one_to_many :records, primary_key: :id
end
