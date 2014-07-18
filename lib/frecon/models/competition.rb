module FReCon
	class Competition
		include Mongoid::Document
		include Mongoid::Timestamps

		field :location, type: String
		field :name, type: String

		has_many :matches

		validates :location, :name, presence: true

		def records
			Record.where match: self.matches
		end

		def teams
			competition_records = records

			Team.where id: competition_records.map { |record| record.team_id }
		end
	end
end
