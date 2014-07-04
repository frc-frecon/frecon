class Team
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String
	field :location, type: String

	has_many :participations
	has_many :records
end
