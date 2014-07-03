class Match
	include Mongoid::Document
	include Mongoid::Timestamps

	belongs_to :competition
	has_many :records
end
