module FReCon
	class Team
		include Mongoid::Document
		include Mongoid::Timestamps

		field :number, type: Integer

		field :location, type: String
		field :name, type: String

		has_many :records

		validates :number, presence: true, uniqueness: true, numericality: { greater_than: 0 }

		def self.number(team_number)
			# Team.find_by number: team_number
			find_by number: team_number
		end

		# Returns all of the matches that this team has been in.
		def matches
			Match.where record: self.records
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
