require "frecon/position"

module FReCon
	class Record
		include Mongoid::Document
		include Mongoid::Timestamps
		include Mongoid::Attributes::Dynamic
		
		field :notes, type: String
		field :position, type: Position

		belongs_to :match
		belongs_to :team

		validates :position, :match_id, :team_id, presence: true

		def competition
			self.match.competition
		end
	end
end
