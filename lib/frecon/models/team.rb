module FReCon
	class Team < Model
		field :number, type: Integer

		field :location, type: String
		field :name, type: String

		has_many :records, dependent: :destroy

		validates :number, presence: true, uniqueness: true, numericality: { greater_than: 0 }

		def self.number(team_number)
			# Team.find_by number: team_number
			find_by number: team_number
		end

		# Returns all of the matches that this team has been in.
		# Optionally, returns the matches that this team has played
		# in a certain competition.
		def matches(competition_id = nil)
			records = self.records
			matches = Match.in record_id: records.map { |record| record.id }
			matches = matches.where competition_id: competition_id unless competition_id.nil?

			matches
		end

		# Returns all of the competitions that this team has been in.
		def competitions
			current_matches = matches
			
			Competition.in match_id: current_matches.map { |match| match.id }
		end

		# alias_method works by default solely on instance
		# methods, so change context to the metaclass of
		# Team and do aliasing there.
		class << self
			alias_method :with_number, :number
			alias_method :that_has_number, :number
		end

	end
end
