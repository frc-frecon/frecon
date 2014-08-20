require "frecon/model"

module FReCon
	class Competition < Model
		field :location, type: String
		field :name, type: String

		has_many :matches, dependent: :destroy
		has_many :participations, dependent: :destroy

		validates :location, :name, presence: true
		validates :name, uniqueness: true

		def records
			matches = self.matches

			Record.in match_id: matches.map(&:id)
		end

		def teams
			Team.in id: participations.map(&:team_id)
		end
	end
end
