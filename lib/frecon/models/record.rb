require_relative "../position.rb"

module FReCon
	class Record
		include Mongoid::Document
		include Mongoid::Timestamps

		field :notes, type: String
		field :position, type: Position

		belongs_to :match
		belongs_to :team

		validates :position, :match_id, :team_id, presence: true
	end
end
