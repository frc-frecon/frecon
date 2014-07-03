class Record
	include Mongoid::Document
	include Mongoid::Timestamps

	belongs_to :team
	belongs_to :match
end
