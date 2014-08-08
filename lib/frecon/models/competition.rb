require "frecon/model"

module FReCon
	class Competition < Model
		field :location, type: String
		field :name, type: String

		has_many :matches, dependent: :destroy
		has_many :participations, dependent: :destroy
		has_many :teams, through: :participations
		
		validates :location, :name, presence: true
		validates :name, uniqueness: true

		def records
			matches = self.matches

			Record.in match_id: matches.map { |match| match.id }
		end
	end
end
