require "frecon/position"

module FReCon
	class Record
		include Mongoid::Document
		include Mongoid::Timestamps

		field :notes, type: String
		field :position, type: Position

		belongs_to :match
		belongs_to :participation

		validates :position, :match_id, :participation_id, presence: true
	end
end
