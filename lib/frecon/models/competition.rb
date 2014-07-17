module FReCon
	class Competition
		include Mongoid::Document
		include Mongoid::Timestamps

		field :location, type: String
		field :name, type: String

		has_many :matches

		validates :location, :name, presence: true

		def records
			self.matches.map{
				|match|
				match.records
			}.flatten.uniq
		end

		def teams
			self.records.map{
				|record|

				record.team.number
			}.flatten.uniq
		end
	end
end
