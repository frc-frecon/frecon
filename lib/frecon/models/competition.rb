module FReCon
	class Competition
		include Mongoid::Document
		include Mongoid::Timestamps
		include Mongoid::Attributes::Dynamic

		field :location, type: String
		field :name, type: String

		has_many :matches
		
		validates :location, :name, presence: true
		validates :name, uniqueness: true

		def records
			matches = self.matches
			
			Record.where match_id: matches.map { |match| match.id.to_s }
		end

		def teams
			competition_records = records

			Team.find competition_records.map { |record| record.team_id.to_s }
		end
	end
end
