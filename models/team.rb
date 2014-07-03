class Team
	include Mongoid::Document
	include Mongoid::Timestamps

	has_many :participations
	has_many :records
end
