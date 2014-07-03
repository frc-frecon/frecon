class Competition
	include Mongoid::Document
	include Mongoid::Timestamps

	has_many :participations
	has_many :matches
end
