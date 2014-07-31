require "frecon/model"

module FReCon
	class Competition < Model
		field :location, type: String
		field :name, type: String

		has_many :matches, dependent: :destroy

		validates :location, :name, presence: true
		validates :name, uniqueness: true

		def records
			matches = self.matches

			Record.in match_id: matches.map { |match| match.id }
		end

		def teams
			competition_records = records

			Team.find competition_records.map { |record| record.team_id }
		end
	end
end
